# SOLID Principles in Software Design

## 1. Single Responsibility Principle (SRP)

### What is SRP?

- A class should have **only one reason to change**.
- It should have **only one responsibility** or purpose.

### How to Achieve SRP?

- Divide responsibilities across multiple classes.
- Each class should focus on a single concern (e.g., authentication, data persistence, or email communication).
- Use **service classes** and **repositories** to separate logic.

### Why is this important?

- Improves **maintainability** and **scalability**.
- Reduces **unnecessary changes** to unrelated functionalities.
- Makes testing **easier and more focused**.

### Example of SRP Violation

A `UserService` that handles multiple responsibilities:

```dart
class UserService {
  void createUser(User user) {
    // Business logic for user creation
  }

  void saveUserToDatabase(User user) {
    // Saves user to the database
  }

  void sendWelcomeEmail(User user) {
    // Sends a welcome email
  }
}
```

### - Problems:

- If **email logic** changes → `UserService` is affected.
- If **database logic** changes → `UserService` is affected.
- **Multiple reasons to change!** 🚨

### Applying SRP Correctly

We split responsibilities into separate classes:

```dart
class UserRepository {
  void saveUser(User user) {
    // Save user to DB
  }
}

class UserNotifier {
  void sendWelcomeEmail(User user) {
    // Send email
  }
}

class UserManager {
  final UserRepository _repository;
  final UserNotifier _notifier;

  UserManager(this._repository, this._notifier);

  void registerUser(User user) {
    _repository.saveUser(user);
    _notifier.sendWelcomeEmail(user);
  }
}
```

### - Benefits of this approach:

- If **email system** changes → Modify `UserNotifier` only.
- If **database structure** changes → Modify `UserRepository` only.
- `UserManager` focuses purely on **user-related business logic**.

✅ Now, each class has **only one reason to change**, following SRP properly! 🎯

---

## 2. Open/Closed Principle (OCP)

### **What is OCP?**

The Open/Closed Principle states that **software entities should be open for extension but closed for modification**. You should be able to add new functionality without changing the existing code.

### **How to Achieve OCP?**

- Use **abstract classes**, **interfaces**, or **sealed classes** to allow extension without modification.
- Implement **polymorphism** to handle new cases dynamically.

### **Why Follow OCP?**

- Reduces the risk of breaking existing functionality.
- Encourages scalable and modular code design.
- Makes the system more adaptable to changes.

### **Example: Violating OCP (Wrong Approach)**

```dart
class PaymentProcessor {
  void processPayment(String paymentMethod, double amount) {
    if (paymentMethod == 'credit_card') {
      // Process credit card payment
    } else if (paymentMethod == 'paypal') {
      // Process PayPal payment
    }
  }
}

// If we want to add a new payment method, we need to modify the `PaymentProcessor` class.
```

### **Example: Following OCP (Correct Approach)**

```dart
abstract class PaymentMethod {
  void processPayment(double amount);
}

class CreditCardPayment implements PaymentMethod {
  @override
  void processPayment(double amount) {
    // Process credit card payment
  }
}

class PayPalPayment implements PaymentMethod {
  @override
  void processPayment(double amount) {
    // Process PayPal payment
  }
}

class PaymentProcessor {
  void processPayment(PaymentMethod method, double amount) {
    method.processPayment(amount);
  }
}
```

---

## 3. Liskov Substitution Principle (LSP)

### **What is LSP?**

The Liskov Substitution Principle states that **subtypes must be substitutable for their base types** without altering the correctness of the program.

### **How to Achieve LSP?**

- Use **proper abstraction** to define parent classes.
- Ensure child classes **don’t break parent class behavior**.
- Avoid overriding methods in a way that changes expected behavior.

### **Why Follow LSP?**

- Prevents unexpected errors when using derived classes.
- Ensures a consistent behavior across class hierarchies.

### **Example: Violating LSP (Wrong Approach)**

```dart
abstract class UserAuth {
  bool login(String username, String password) {
    print('Standard login process');
    return true;
  }
}

class AdminAuth extends UserAuth {
  @override
  bool login(String username, String password) {
    if (username != 'admin') {
      throw Exception('Only admin users allowed!');
    }
    return super.login(username, password);
  }
}
```

### **Example: Following LSP (Correct Approach)**

```dart
abstract class UserAuth {
  bool authenticate(String username, String password);
}

class StandardAuth implements UserAuth {
  @override
  bool authenticate(String username, String password) {
    print('Standard login process');
    return true;
  }
}

class AdminAuth implements UserAuth {
  @override
  bool authenticate(String username, String password) {
    print('Admin login process with extra verification');
    return username == 'admin' && password.length > 8;
  }
}
```

---

## 4. Interface Segregation Principle (ISP)

### **What is ISP?**

The Interface Segregation Principle states that **clients should not be forced to depend on interfaces they do not use**.

### **How to Achieve ISP?**

- Use **multiple specific interfaces** instead of a large general-purpose interface.
- Apply **mixins** in Dart to add functionality dynamically.

### **Why Follow ISP?**

- Prevents unnecessary dependencies in classes.
- Improves flexibility and reduces code complexity.

### **Example: Violating ISP (Wrong Approach)**

```dart
abstract class MultiFunctionDevice {
  void print(Document document);
  void scan(Document document);
  void fax(Document document);
  void copy(Document document);
}
```

### **Example: Following ISP (Correct Approach)**

```dart
abstract class Printer {
  void print(Document document);
}

abstract class Scanner {
  void scan(Document document);
}

class BasicPrinter implements Printer {
  @override
  void print(Document document) {
    // Print implementation
  }
}
```

---

## 5. Dependency Inversion Principle (DIP)

### **What is DIP?**

The Dependency Inversion Principle states that **high-level modules should not depend on low-level modules. Both should depend on abstractions**.

### **How to Achieve DIP?**

- Use **dependency injection** instead of hardcoding dependencies.
- Depend on **abstractions (interfaces)** rather than concrete implementations.

### **Why Follow DIP?**

- Enhances flexibility and testability.
- Makes the system loosely coupled and easier to modify.

### **Example: Violating DIP (Wrong Approach)**

```dart
class EmailSender {
  void sendEmail(String to, String message) {
    // Send email logic
  }
}

class NotificationService {
  final EmailSender emailSender = EmailSender();

  void notify(User user, String message) {
    emailSender.sendEmail(user.email, message);
  }
}
```

### **Example: Following DIP (Correct Approach)**

```dart
abstract class MessageSender {
  void sendMessage(String to, String message);
}

class EmailSender implements MessageSender {
  @override
  void sendMessage(String to, String message) {
    // Send email implementation
  }
}

class NotificationService {
  final MessageSender sender;

  NotificationService(this.sender);

  void notify(User user, String message) {
    sender.sendMessage(user.contactInfo, message);
  }
}
```

---

Following these SOLID principles ensures **clean, scalable, and maintainable** code!
