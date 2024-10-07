class Todo {
  final String text;
  final int id;
  final bool isCompleted;

  Todo({
    required this.text,
    required this.id,
    this.isCompleted = false,
  });

  Todo toggleCompletion() {
    return Todo(
      text: text,
      id: id,
      isCompleted: !isCompleted,
    );
  }
}
