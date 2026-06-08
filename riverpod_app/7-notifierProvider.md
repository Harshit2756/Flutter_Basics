This tutorial explores **Notifier** and **NotifierProvider** in *Riverpod*, the modern standard for managing complex state logic and business functions within a *Flutter* application. This approach allows you to encapsulate business logic inside a clean controller class, completely avoiding deprecated legacy providers.

### **Key Concepts**
* **Notifier**: A class that extends `Notifier<T>`, which holds your state (`T`), defines its initial value via a `build()` method, and exposes methods to mutate that state.
* **NotifierProvider**: The provider used to link your UI widgets to your modern `Notifier` logic.
* **State Immutability**: You must always treat the state as immutable. To update a list or an object, you create a new instance rather than modifying the existing one.
* **CopyWith Pattern**: Essential for updating specific fields in an immutable class while keeping others unchanged.
---

### **The Core Philosophy: Why is Immutability Vital in Riverpod?**

Before looking at complex state objects, it is critical to understand why **immutability** (keeping data unchangeable after it is created) is mandatory in Riverpod.

Riverpod checks if a state has changed by comparing its memory reference pointer (`==`). If the memory address hasn't changed, Riverpod assumes nothing happened and skips updating the screen.

- **The Flawed Way (Direct Mutation):**

```dart
final myTodo = ToDo(id: 1, title: "Buy Milk", completed: false);
myTodo.completed = true; // Changing a value inside the same object
```

* *Why it breaks:* The object location in memory remains exactly the same. Riverpod looks at the pointer, detects no change, and **does not** rebuild your UI. Your screen stays out of sync.
* **The Correct Way (Immutability & CopyWith):**

```dart
final originalTodo = ToDo(id: 1, title: "Buy Milk", completed: false);
final updatedTodo = originalTodo.copyWith(completed: true); // Creates a fresh object
```

*Why it works:* `updatedTodo` lives at a brand-new memory address. Riverpod spots the new reference instantly and cleanly redraws your UI.

This approach also ensures **thread-safety**. Because objects cannot change under the hood, your background processes or asynchronous functions won't unexpectedly overwrite data while the UI is trying to render it.

---

### **Example 1: Todo Logic**

This example demonstrates how to create a controller for manipulation.

**The Model:**
Ensure your model has a `copyWith` method to generate new instances:

```dart
class ToDo {
  final int id;
  final String title;
  final bool completed;

  ToDo({required this.id, required this.title, required this.completed});

  ToDo copyWith({int? id, String? title, bool? completed}) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
```

**Controller Class:**
In Riverpod 3.0, initial state is defined by overriding the `build()` method inside the class.
To add an item, you create a new list including the old state: `state = [...state, newToDo];`.
To toggle a status, you find the index, use `copyWith` to flip the boolean, and assign the new list to `state`.

```dart
// Explicit declaration without Code Generation
final todoListProvider = NotifierProvider<TodoListNotifier, List<ToDo>>(() {
  return TodoListNotifier();
});

class TodoListNotifier extends Notifier<List<ToDo>> {
  // Overriding build() sets the initial state synchronously
  @override
  List<ToDo> build() {
    return []; // Initial state value
  }

  void add(String title) {
    final newTodo = ToDo(
      id: state.isEmpty ? 0 : state.last.id + 1,
      title: title,
      completed: false,
    );

    state = [...state, newTodo]; // Replaces list pointer
  }

  void remove(int id) {
    state = state.where((t) => t.id != id).toList(); // Creates a new list instance
  }

  void toggle(int id) {
    final todos = [...state];

    final index = todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final todo = todos[index];
    todos[index] = todo.copyWith(completed: !todo.completed);

    state = todos; // Replaces the old state pointer with the new list pointer
  }
}

```

**Usage in UI:**
Use `ref.watch(todoListProvider)` to listen to values and `ref.read(todoListProvider.notifier)` to call functions.

---

```dart
class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);
    final notifier = ref.read(todoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Add Todo
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'New task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      notifier.add(text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// List Todos
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (_, i) {
                  final todo = todos[i];
                  return ListTile(
                    leading: Checkbox(
                      value: todo.completed,
                      onChanged: (_) => notifier.toggle(todo.id),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => notifier.remove(todo.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Automating Immutability: The Freezed Package
While implementing manual data models works well for tiny apps, writing custom copyWith code, structural deep equality (==), and toString() setups for dozens of production classes quickly turns into a massive chore.

* Freezed is a dedicated code-generation package that completely handles this heavy lifting for you.

### How the Model Changes with Freezed:
Instead of physically typing out constructors and mapping rules, you declare your properties like this:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart'; // Required only if you are handling JSON serialization

@freezed
class ToDo with _$ToDo {
  const factory ToDo({
    required int id,
    required String title,
    required bool completed,
  }) = _ToDo;

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);
}
```
### Core Benefits of Using Freezed
1.  Eliminates Boilerplate: Freezed automatically generates copyWith, toString(), and serialization methods. If your data model expands from 3 items to 25 items down the road, you never have to manually map code signatures.
2. Enforced Immutability: Freezed automatically marks generated properties as final. It makes it impossible to accidentally write code that updates data directly (e.g., todo.completed = true won't pass compilation).
3. Deep Equality Comparisons: Dart checks instances by default pointer reference. Freezed overrides the == operator and hashCode automatically. If two separate Freezed items have identical parameter values, Dart registers them as structurally equal. This limits unnecessary Riverpod UI redraw loops.
4. Sealed Classes / Union Types: You can seamlessly bundle complex asynchronous UI states:

```dart
@freezed
    class TodoState with _$TodoState {
      const factory TodoState.loading() = _Loading;
      const factory TodoState.data(List<ToDo> todos) = _Data;
      const factory TodoState.error(String message) = _Error;
    }
```
This structural pattern forces your widget build contexts to map all possibilities cleanly using a `.when()` branch, minimizing runtime rendering bugs.

#### **When to Choose Manual vs. Freezed**

| Feature | Manual Implementation | Freezed Package |
| :--- | :--- | :--- |
| **Boilerplate** | High (must code parameters, `copyWith`, and `==` manually) | None (Handled by running `build_runner` code generation) |
| **Scalability** | Demands maintenance cycles as data variables grow | Scales instantly with simple property lines |
| **State Safety** | Vulnerable to human syntax oversights | Robust, type-safe, and compile-time strictly managed |
| **Complexity** | Great for simple learning labs or limited small logic blocks | The choice for scalable production apps and API structures |

---

### **Best Practices**
1.  **Immutability:** Never modify `state` directly for lists (e.g., `state.add()`). Always use `state = [...state, newItem]`.
2.  **Performance (`ref.watch` vs `ref.read`):** * Use `ref.watch` in your `build` method to continuously observe state changes and trigger real-time UI updates whenever the data changes.
    * Use `ref.read` inside event handlers (like `onPressed`) to fetch a one-time snapshot of your controller or data without creating an ongoing subscription, preventing redundant UI rebuilds during user interactions.
3.  **Lifecycle:** Use `ConsumerStatefulWidget` to easily integrate `TextEditingController` and properly `dispose` of resources to prevent memory leaks.
4.  **Scaling:** Incorporate **Freezed** early when designing larger applications to drop repetitive boilerplate work and lock down architectural state safety.

## [Next Topic: *AsyncNotifierProvider*](8-asyncNotifierProvider.md)
