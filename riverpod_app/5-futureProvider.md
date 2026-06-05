### Master FutureProvider in Flutter Riverpod

This tutorial covers how to handle asynchronous operations in Flutter using `FutureProvider`. It focuses on avoiding boilerplate code while managing loading, error, and data states efficiently.

---

#### 1. Why use FutureProvider?

Instead of manually managing `FutureBuilder`, `try-catch` blocks, and separate loading variables, `FutureProvider` provides a structured way to handle async data. It automatically manages the lifecycle of the data and provides a state-driven UI.

#### 2. Creating a Fake API Service (03:00)

First, we create a service class that simulates a network request. It includes a random chance to throw an exception to demonstrate robust error handling.

```dart
class FakeService {
  Future<String> fetchGreetings() async {
    await Future.delayed(const Duration(seconds: 2));
    if (Random().nextDouble() < 0.3) {
      throw Exception("Failed to fetch greetings");
    }
    return "Hello from async";
  }
}

// Create the instance in a provider
final fakeApiProvider = Provider((ref) => FakeService());
```

#### 3. Defining the FutureProvider

The `FutureProvider` consumes the service provider to fetch data. It handles the `async` nature of the request internally.

```dart
final greetingsFutureProvider = FutureProvider<String>((ref) async {
  final service = ref.read(fakeApiProvider);
  return await service.fetchGreetings();
});
```

#### 4. UI Implementation: The `.when()` Method 

Using `ConsumerWidget`, you can listen to the provider. The `.when()` method is the core of `FutureProvider`, allowing you to define distinct UIs for **Loading**, **Error**, and **Data** states.

### [Docs for all the parameters](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/AsyncValueExtensions/when.html)

```dart
/// Create a Future Provider
final greetingFutureProvider = FutureProvider((Ref ref) async {
  final service = ref.read(fakeApiProvider);
  return await service.fetchGreeting();
});

/// UI Screen to display Future data
class GreetingScreen extends ConsumerWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the FutureProvider
    final greetingAsync = ref.watch(greetingFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Async Greeting')),
      body: Center(
        /// Load data
        child: greetingAsync.when(
          skipLoadingOnRefresh: false,
          data: (greeting) =>
              Text(greeting, style: const TextStyle(fontSize: 24)),
          error: (error, stackTrace) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.refresh(greetingFutureProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

```

        #### 5. Caching and Refreshing 

- **Caching:** `FutureProvider` caches the result after the first fetch. Subsequent widget rebuilds will not trigger a new API call.
- **Refresh:** Use `ref.refresh(provider)` to invalidate the cache and trigger a new request. This is ideal for "pull-to-refresh" or "retry" buttons. For more ref methods [see here](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/Ref-class.html)
- **Refined UI:** You can customize the `.when` behavior by setting `skipLoadingOnRefresh: false` if you want the loader to show even during a retry.


## [Next Topic: *StreamProvider*](6-streamProvider.md)
