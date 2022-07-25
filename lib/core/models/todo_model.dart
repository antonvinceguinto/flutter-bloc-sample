class Todo {
  const Todo({
    this.id,
    this.title,
    this.completed = false,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  final String? id;
  final String? title;
  final bool completed;

  Todo copyWith({
    required String id,
    required String title,
    required bool completed,
  }) {
    return Todo(
      id: id,
      title: title,
      completed: completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
