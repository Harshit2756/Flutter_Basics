This tutorial covers the implementation of **AsyncNotifier** and **AsyncNotifierProvider** in *Flutter Riverpod*, which is essential for managing asynchronous operations like API calls, database interactions, and handling loading/error states seamlessly without relying on code generation.

### **Key Concepts**
* **AsyncNotifier Provider:** Used when you need to perform multiple functions (like a CRUD operation) that involve asynchronous logic. Unlike a simple `FutureProvider`, it uses a class-based approach where mutations live directly inside the controller.
* **AsyncValue:** The core state container in an `AsyncNotifier`. It wraps your data and automatically tracks three distinct phases: `AsyncLoading`, `AsyncError`, and `AsyncData` (Success).
* **State Management Strategies:**
    * **Manual Handling:** Using explicit `try-catch` blocks to manually transition the state to `AsyncValue.loading()`, `AsyncValue.data()`, or `AsyncValue.error()`.
    * **Guard Pattern:** A cleaner, production-recommended approach using `AsyncValue.guard()`, which automatically intercepts side-effect exceptions and transforms them into an `AsyncError` state for your UI to catch.

---

### **The Core Philosophy: Why AsyncNotifier over basic FutureProviders?**

While a simple `FutureProvider` can fetch data once, it cannot easily host custom logic or internal side-effect functions (like adding, deleting, or updating items on a server). 

`AsyncNotifier` bridges this gap: it allows you to asynchronously download your initial state, *and* provides a home to write custom methods that update that remote state seamlessly.

---

### **Advanced Mechanics: State Transitions Under the Hood**

When mutating asynchronous data, how you handle the intermediate state changes determines whether your app looks fluid or clunky.

#### **1. Hard Loading (`state = const AsyncValue.loading()`)**
Explicitly overwriting the state with a fresh loading value completely empties out the provider's data slot. 
* **UI Impact:** The current data on the screen completely vanishes and is replaced by a full-screen loading spinner.
* **Best Used For:** Pull-to-refresh actions, heavy sorting alterations, or the initial app boot.

#### **2. Background Preservation (`await future`)**
Instead of manually forcing a hard loading state, you read the current state safely by awaiting the notifier’s internal `.future` property:
```dart
final previousState = await future;
```
* **UI Impact:** The existing screen data remains completely visible to the user while the remote background server request executes. Once the request succeeds, the UI cleanly updates with the new data.
* **Best Used For:** Micro-interactions like checking a to-do list checkbox, liking a post, or adding an item to a list where full-screen flickers ruin the UX.

### Example Implementation
To create an `AsyncNotifier`, define a class that extends `AsyncNotifier<T>` and implement the `build()` method.

```dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Explicit provider declaration without Code Generation
final greetingAsyncProvider = AsyncNotifierProvider<GreetingAsyncNotifier, String>(
  () => GreetingAsyncNotifier(),
);

class GreetingAsyncNotifier extends AsyncNotifier<String> {
  // Sets up the initial data fetch asynchronously
  @override
  FutureOr<String> build() async {
    // ref is globally accessible inside an AsyncNotifier class
    return await ref.read(fakeApiProvider).fetchGreeting();
  }

  /// Strategy A: Background Preservation using Guard (Recommended for Micro-mutations)
  Future<void> refreshGreetingImplicit() async {
    // We do NOT call state = const AsyncValue.loading() here.
    // The current greeting stays visible on screen while the new one fetches in the background.
    state = await AsyncValue.guard(() async {
      return await ref.read(fakeApiProvider).fetchGreeting();
    });
  }

  /// Strategy B: Manual Handling with Hard Loading (Recommended for Pull-to-Refresh)
  Future<void> refreshGreetingHardLoad() async {
    state = const AsyncValue.loading(); // Wipes the screen, forcing the UI loading indicator
    try {
      final value = await ref.read(fakeApiProvider).fetchGreeting();
      state = AsyncValue.data(value);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
```

### UI Integration


In your UI, use the `when` method on the `AsyncValue` to handle the different UI states (13:42):


```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'async_notifier.dart';

class AsyncGreetingScreen extends ConsumerWidget {
  const AsyncGreetingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // 1. PLACE ref.listen AT THE TOP OF YOUR BUILD METHOD
    // This constantly monitors the provider for side-effects (like errors)
    ref.listen<AsyncValue<String>>(greetingAsyncProvider, (previous, next) {
      if (next hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).clearSnackBars(); // Clear existing snackbars
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Action failed: ${next.error}'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    // 2. Watch the state normally to render the body elements
    final greetingAsync = ref.watch(greetingAsyncProvider);
    
    // 3. Read the notifier for button event interactions
    final notifier = ref.read(greetingAsyncProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Async Notifier Demo')),
      body: Center(
        child: greetingAsync.when(
          // 1. Loading Phase
          loading: () => const CircularProgressIndicator(),
          // 2. Error Phase
          error: (error, stackTrace) => Text('Error: $error', style: const TextStyle(color: Colors.red)),
          // 3. Success Phase (Data)
          data: (greetingText) => Text(greetingText, style: const TextStyle(fontSize: 24)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => notifier.refreshGreetingImplicit(), // Triggers mutation cleanly
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```


### Summary of Best Practices
*   **Read vs Watch Controllers:** Always use ref.watch(provider) to render state changes inside your build methods. Use ref.read(provider.notifier) inside button actions or operational click handlers to perform functions without introducing performance drops.
*   **State Preservation:** Be mindful of state = AsyncValue.loading(). Wiping the state during minor mutations causes sudden asset flickering. Leverage await future to handle seamless asynchronous data steps silently.
*   **Error Handling via Snackbars (Side-Effects):** While .when() works perfectly for updating the main body UI, avoid using it to show popups or Snackbars. For temporary user warnings during mutations, listen to your provider errors inside the UI build block using ref.listen:
```dart
ref.listen<AsyncValue<String>>(greetingAsyncProvider, (previous, next) {
  if (next is AsyncError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Action failed: ${next.error}')),
    );
  }
});
```
*   **Scalability:** *AsyncNotifier* provides the absolute ideal foundation for production applications. It neatly separates remote API routing, exceptions mapping, and data storage structures away from the design layout tree.

## [Next Topic: *Family and AutoDispose*](9-family_and_autoDispose.md)
