This tutorial covers **StreamProvider** in Flutter using *Riverpod*, a powerful state management solution that simplifies asynchronous data handling and memory management.


### **Key Concepts**


*   **Automatic Disposal:** Unlike manual stream handling, *Riverpod* automatically manages the lifecycle of streams. When a screen is disposed of or a provider is no longer in use, the stream is paused or destroyed, preventing memory leaks.
*   **AsyncValue:** *Riverpod* provides the `AsyncValue` class to handle the three states of an asynchronous operation: **Loading**, **Error**, and **Success (Data)**.
*   **Caching:** *Riverpod* caches the last emitted value. Navigating away and returning to a screen will display the previous data immediately while the stream re-establishes.
*   **Retry Mechanism:** By using `ref.refresh()`, you can force a provider to re-execute, effectively restarting a stream after an error.


### **Code Examples**


#### **1. Creating a provider for streams**
We create a `TimerService` that emits an integer every second. This service is provided using a `Provider`, and the stream is consumed using a `StreamProvider`. 

```dart
final timerServiceProvider = Provider((_) => TimerService());

class TimerService {
  // Emits an integer every second, starting at 0
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (count) => count);
  }

  // In TimerService:
  Stream<int> tickWithError() async* {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
    throw Exception('Timer stopped unexpectedly!');
  }
}

```

#### **2. Handling Stream States in UI Using StreamProvider**
We create a `StreamProvider` that listens to the `tickWithError()` or `tick()` method of the `TimerService`. Use the `.when()` method on the `AsyncValue` to handle UI states cleanly. 


```dart
final tickerProvider = StreamProvider((Ref ref) {
  final service = ref.read(timerServiceProvider);
  return service.tickWithError();
});

/// UI Screen to display data
class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickAsync = ref.watch(tickerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Timer')),
      body: Center(
        child: tickAsync.when(
          skipLoadingOnRefresh: false,
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.refresh(tickerProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
          data: (count) => Text(
            'Seconds elapsed: $count',
            style: const TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
```
### **Best Practices**
*   **Clean Architecture:** Move your stream logic into a separate Service class (like a `TimerService`) and provide it via a provider rather than writing logic directly inside the UI or the provider function.
*   **skipLoadingOnRefresh:** Set this property to `false` in the `.when()` or similar builders if you want to show the loading spinner again when a user triggers a manual refresh.

## [Next Topic: *NotifierProvider*](7-notifierProvider.md)
