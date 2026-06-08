# Clean Architecture in Flutter - E-commerce App Example

## 📁 Project Folder Structure

```
lib/
 ├── core/
 │   ├── utils/
 │   ├── error/
 │   ├── network/
 │
 ├── features/
 │   ├── product/
 │   │   ├── data/
 │   │   │   ├── models/
 │   │   │   ├── repositories/
 │   │   │   ├── data_sources/
 │   │   ├── domain/
 │   │   │   ├── entities/
 │   │   │   ├── usecases/
 │   │   │   ├── repositories/
 │   │   ├── presentation/
 │   │       ├── screens/
 │   │       ├── widgets/
 │   │       ├── bloc/
 │
 ├── main.dart
```

---

## 📌 How to Decide If Something Is a Feature?

Use these **questions** to determine whether something should be a feature:

1. **Does it have its own UI screen?**
2. **Does it require its own business logic?**
3. **Does it need a separate API or database interaction?**
4. **Will it be reused across multiple parts of the app?**
5. **Would removing it break other features?**

If the answer is **YES** to most of these, it should be a **separate feature**.

---

## Overview

Clean Architecture helps in structuring the app into well-defined layers, making it **scalable, maintainable, and testable**. It consists of three main layers:

1. **Domain Layer** (Business Logic, Independent of Flutter)
2. **Data Layer** (Repository, API, Database, External Dependencies)
3. **Presentation Layer** (UI, State Management)

---

## 1. Domain Layer

The **domain layer** is the core of Clean Architecture. It contains **business logic** and should be completely independent of other layers.

### a) Entities

**What?**

- Entities are core business objects that represent **data** and its **rules**.
- They should not depend on external packages (Firebase, API, etc.).

**Why?**

- Keeps business rules reusable and testable.
- Ensures independence from data sources.
- Encourages consistency in handling core business logic.

**Example:**

```dart
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}
```

### b) Use Cases

**What?**

- Use cases define specific business logic that the app should perform.
- Each use case is a single responsibility function (e.g., "Get Product List", "Add to Cart").

**Why?**

- Separates **application logic** from UI & data sources.
- Makes testing and modifying logic easier.

**Example:**

```dart
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> execute() async {
    return await repository.getProducts();
  }
}
```

### c) Abstract Repository

**What?**

- An interface that defines how data should be accessed.
- The **domain layer** does not depend on actual implementations.

**Why?**

- Allows switching data sources easily (API, local DB, mock data).
- Ensures clear contracts between layers.

**Example:**

```dart
abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
```

---

## 2. Data Layer

The **data layer** is responsible for fetching and storing data. It consists of:

1. **Repository Implementation**
2. **Data Sources (Remote, Local)**
3. **Models (DTOs)**

### a) Repository Implementation

**What?**

- Implements the abstract repository.
- Decides where to fetch data from (API, cache, etc.).

**Why?**

- Keeps data fetching logic separate from business logic.
- Allows caching, error handling, and transformations.

**Example:**

```dart
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDataSource.fetchProducts();
  }
}
```

### b) Data Sources

**What?**

- Handles actual API calls or local DB queries.
- Divided into **RemoteDataSource** (API) and **LocalDataSource** (DB).

**Why?**

- Keeps API/DB logic separate from the repository.
- Makes switching databases or APIs easier.

**Example:**

```dart
class ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSource(this.client);

  Future<List<Product>> fetchProducts() async {
    final response = await client.get(Uri.parse('https://api.example.com/products'));
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
```

### c) Models (DTOs)

**What?**

- Simple objects used only for transferring data between layers (e.g., API responses).
- Often convert from JSON to Dart objects.
- Do not contain business logic.

**Why?**

- Helps decouple the app from API responses or database schemas.
- Keeps the domain layer clean & independent from external data structures.

**How?**

- Create a DTO for each API response.
- Convert DTOs to domain entities when needed.

**Note(DTO vs Entity):**
| Feature | Entity (Domain Layer) | DTO (Data Layer) |
|---------|------------------------|------------------|
| Purpose | Represents core business logic | Transfers data between layers (API, DB) |
| Contains Logic? | ✅ Yes, business rules | ❌ No, only data conversion |
| Independent? | ✅ Yes (doesn't depend on API/DB) | ❌ No (linked to external sources) |
| Where Used? | Domain layer (core business) | Data layer (repositories, services) |
| Conversion? | ❌ No conversion needed | ✅ Converts to/from JSON & Entities |

**Example:**

```dart
class ProductDto {
  final String id;
  final String name;
  final double price;

  ProductDto({required this.id, required this.name, required this.price});

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(id: json['id'], name: json['name'], price: json['price']);
  }

  Product toDomain() {
    return Product(id: id, name: name, price: price);
  }
}
```

---

## 3. Presentation Layer

The **presentation layer** handles UI and state management.

### a) UI (Widgets)

**What?**

- Displays data and user interactions.
- Uses **stateless** and **stateful widgets**.

**Why?**

- Separates UI logic from business logic.
- Keeps UI reactive and dynamic.

**Example:**

```dart
class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: ProductListView(),
    );
  }
}
```

### b) State Management (Bloc, Provider, Riverpod)

**What?**

- Handles UI state, business logic interaction.
- Uses patterns like **Bloc, Provider, Riverpod**.

**Why?**

- Keeps UI separate from logic.
- Avoids unnecessary rebuilds.

**Example (Bloc):**

```dart
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc(this.getProductsUseCase) : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProducts) {
      yield ProductLoading();
      try {
        final products = await getProductsUseCase.execute();
        yield ProductLoaded(products);
      } catch (e) {
        yield ProductError('Failed to load products');
      }
    }
  }
}
```

---

## Conclusion

Clean Architecture in Flutter improves maintainability, testability, and scalability. By separating concerns into **Domain, Data, and Presentation layers**, we create a **robust** and **future-proof** e-commerce app.
