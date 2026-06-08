# 🔥 Complete Glossary of BLoC Terms

Here's an in-depth breakdown of all BLoC concepts, explaining what they do, when to use them, and how they work internally.

## 📌 1. Bloc (Business Logic Component)

### ✅ What is it?

- The core component of the BLoC pattern that manages state and events.
- Separates business logic from UI, making the app scalable and maintainable.

### ✅ How it works?

- Listens for events, processes them, and emits new states.

### ✅ Example:

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0); // Initial state

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield state + 1;
    }
  }
}
```

## 📌 2. BlocProvider

### ✅ What is it?

- A widget that provides an instance of a BLoC to its children.
- Ensures efficient memory management (disposes BLoC when not needed).

### ✅ How it works?

- Creates and stores the BLoC instance.

### ✅ Example:

```dart
BlocProvider(
  create: (context) => CounterBloc(),
  child: CounterScreen(),
)
```

## 📌 3. BlocBuilder

### ✅ What is it?

- A widget that listens for state changes and rebuilds the UI accordingly.

### ✅ How it works?

- Calls the builder function every time the BLoC emits a new state.

### ✅ Example:

```dart
BlocBuilder<CounterBloc, int>(
  builder: (context, state) {
    return Text('Count: $state');
  },
)
```

## 📌 4. BlocListener

### ✅ What is it?

- Listens for state changes but does not rebuild the UI.
- Used for side effects (e.g., showing a Snackbar, navigation).

### ✅ Example:

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      Navigator.pushNamed(context, '/home');
    }
  },
  child: LoginScreen(),
)
```

## 📌 5. BlocConsumer

### ✅ What is it?

- Combines BlocBuilder & BlocListener.
- Handles both UI updates and side effects in one place.

### ✅ Example:

```dart
BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      Navigator.pushNamed(context, '/home');
    }
  },
  builder: (context, state) {
    if (state is Loading) {
      return CircularProgressIndicator();
    }
    return Text('Welcome');
  },
)
```

## 📌 6. Repository Pattern (BlocRepositoryProvider)

### ✅ What is it?

- A pattern that separates data-fetching logic from the BLoC.
- Keeps BLoC clean and reusable.

### ✅ Example:

```dart
class UserRepository {
  Future<User> fetchUser() async {
    final response = await Dio().get('https://api.example.com/user');
    return User.fromJson(response.data);
  }
}
```

Providing the repository:

````dart
RepositoryProvider(
  create: (context) => UserRepository(),
  child: MyApp(),
)
📌 Why use it? Makes the BLoC more reusable and testable.

📌 7. BlocObserver
✅ What is it?

A global observer that monitors all BLoC state changes.

Useful for debugging and analytics.

✅ Example:

dart


class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} changed: $change');
    super.onChange(bloc, change);
  }
}
void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
📌 Internally, it hooks into every BLoC and logs changes.

📌 8. HydratedBloc
✅ What is it?

A special type of BLoC that persists state across app restarts.

Uses Hive or SharedPreferences for local storage.

✅ Example:

dart


class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.light());

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return json['isDarkMode'] ? ThemeState.dark() : ThemeState.light();
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {'isDarkMode': state.isDarkMode};
  }
}
📌 Internally, it serializes state to JSON and stores it locally.

📌 9. MultiBlocProvider
✅ What is it?

Provides multiple BLoCs at once in a single widget tree.

✅ Example:

dart


MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => CartBloc()),
  ],
  child: MyApp(),
)
📌 Internally, it combines multiple BlocProviders into a single widget.

📌 10. MultiRepositoryProvider
✅ What is it?

Provides multiple repositories at once.

✅ Example:

dart


MultiRepositoryProvider(
  providers: [
    RepositoryProvider(create: (context) => UserRepository()),
    RepositoryProvider(create: (context) => ProductRepository()),
  ],
  child: MyApp(),
)
📌 Similar to MultiBlocProvider but for repositories.

📌 11. BlocSelector
✅ What is it?

Selects a specific part of the state instead of the whole state.

✅ Example:

``` dart
BlocSelector<UserBloc, UserState, String>(
  selector: (state) => state.user.name,
  builder: (context, name) {
    return Text(name);
  },
)
````

📌 Useful for optimizing performance by only rebuilding when a specific field changes.

🔍 How BLoC Works Under the Hood
1️⃣ UI dispatches an Event.
2️⃣ BLoC receives the event & processes it.
3️⃣ BLoC emits a new state.
4️⃣ UI listens & updates accordingly.

Internally:

BLoC uses Streams to handle state changes.

emit() updates the state synchronously.

Event queue ensures each event is processed one at a time.

🔑 Summary (table)

| Term               | Purpose                                     |
| ------------------ | ------------------------------------------- |
| Bloc               | Manages state and events                    |
| BlocProvider       | Provides a BLoC instance                    |
| BlocBuilder        | Rebuilds UI when state changes              |
| BlocListener       | Handles side effects (e.g., navigation)     |
| BlocConsumer       | Combines BlocBuilder & BlocListener         |
| Repository Pattern | Separates data-fetching from business logic |
| BlocObserver       | Tracks all BLoC state changes               |
| HydratedBloc       | Persists state across restarts              |
| MultiBlocProvider  | Provides multiple BLoCs                     |
| BlocSelector       | Selects specific fields for rebuilding      |
