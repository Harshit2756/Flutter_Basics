
### Flutter Riverpod: Project Setup & Static Provider Notes


This provides a foundational guide to setting up *Riverpod* for state management in *Flutter*. Below are the key takeaways and code implementations.


#### 1. Setup & Installation 
To start, add the `flutter_riverpod` package to your `pubspec.yaml`:
yaml
dependencies:
  flutter_riverpod: ^latest_version


#### 2. ProviderScope
All *Riverpod* apps must be wrapped in a `ProviderScope` at the top level of the widget tree (usually in `main.dart`) to store the state of your providers globally.
```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

#### 3. Creating a Static Provider
A `Provider` is an immutable (static) source of data. It is defined as a global variable outside of any class.

```dart
final stringProvider = Provider<String>((Ref ref) {
  return "Hello World";
});
```

#### 4. Consuming Providers 
To access a provider in the UI, use a `ConsumerWidget` instead of a `StatelessWidget`. This provides a `WidgetRef` object, which allows you to watch the provider.


*   **Watch vs. Read:**
    *   `ref.watch()`: Listens for changes and automatically rebuilds the widget when the provider's value updates.
    *   `ref.read()`: Reads the value once without listening for updates (best for triggers or one-time actions).


**Example UI Implementation:**
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the provider
    final result = ref.watch(stringProvider);
    
    return Text(result); // Outputs: Hello World
  }
}

```


#### 5. Why Static Providers are Useful
*   **Dependency Injection:** They are ideal for providing instances of repositories, API services, or controllers.
*   **Global Access:** Allows you to access data anywhere in the widget tree without passing it through constructors.
*   **Memory Efficiency:** They manage resource creation and disposal automatically within the `ProviderScope`.


## [*Next Topic: Static Provider*](3-stateProvider.md) The tutorial will cover `StateProvider` for handling mutable (dynamic) state.
