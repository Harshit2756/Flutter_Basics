### Flutter Riverpod: ConsumerStatefulWidget Tutorial

This video tutorial explores the **ConsumerStatefulWidget** in _Flutter Riverpod_, which allows developers to use standard _StatefulWidget_ lifecycle methods (like `initState` and `dispose`) while maintaining full access to Riverpod's reactive features.

---

#### 1. Why use ConsumerStatefulWidget?

In standard _ConsumerWidget_ (which is stateless), you cannot easily manage lifecycle events. Attempting to initialize controllers (like `TextEditingController`) inside a `build` method is bad practice because the controller would be re-instantiated whenever the widget rebuilds, causing **memory leaks**.

**Key Use Cases:**

- Managing _TextEditingController_ lifecycle.
- Handling _AnimationController_ and mixins.
- Managing any local state requiring cleanup when the widget is removed.

---

#### 2. Core Concepts & Implementation

**ConsumerStatefulWidget Structure:**
To use it, you replace `StatefulWidget` with `ConsumerStatefulWidget` and `State<T>` with `ConsumerState<T>`. This grants you an automatic `ref` object throughout the state class (03:36 - 04:20).

**Example: Reactive Text Input**

1. **Define a Provider:**

   ```dart
   final textProvider = StateProvider<String>((ref) => '');
   ```

2. **Use Controller:** Use `initState` to attach a listener that updates the provider when text changes .
```dart

class StatefulConsumerTutorial extends ConsumerStatefulWidget {
  const StatefulConsumerTutorial({super.key});

  @override
  ConsumerState<StatefulConsumerTutorial> createState() =>
      _StatefulConsumerTutorialState();
}

class _StatefulConsumerTutorialState
    extends ConsumerState<StatefulConsumerTutorial> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Init controller and listen for changes
    _controller = TextEditingController();
    _controller.addListener(() {
      ref.read(textProvider.notifier).state = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(textProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Text Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(controller: _controller),
            const SizedBox(height: 20),
            Text('You typed: $text'),
          ],
        ),
      ),
    );
  }
}
```

---

#### 3. Practical Animation Example

Using `ConsumerStatefulWidget` ensures that _AnimationController_ resources are released correctly. The video demonstrates an animation that pulses a circle, where the `duration` is fetched from a simple `Provider` and the controller is disposed of when the screen is removed (10:50 - 11:38).

---

#### Quick Summary Table

| Feature       | ConsumerWidget          | ConsumerStatefulWidget   |
| :------------ | :---------------------- | :----------------------- |
| **Type**      | Stateless               | Stateful                 |
| **Lifecycle** | No                      | Yes (initState, dispose) |
| **Use Case**  | Simple UI/Reading state | Controllers/Animations   |

## [*Next Topic: _FutureProvider_*](5-futureProvider.md) 
**Coming up in Video 5:** The series will continue with _FutureProvider_ to handle asynchronous data fetching from APIs or JSON sources 


