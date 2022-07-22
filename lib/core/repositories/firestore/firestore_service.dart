import 'package:bloc_vgv_todoapp/features/todo/cubit/todo_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuple/tuple.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<
      Tuple2<DocumentSnapshot<Map<String, dynamic>>,
          DocumentReference<Map<String, dynamic>>>> getDocument() async {
    final user = FirebaseAuth.instance.currentUser;
    final docRef = _db.collection('todos').doc(user!.email);
    final doc = await docRef.get();
    return Tuple2(doc, docRef);
  }

  Future<void> addTodoData(TodoState todo) async {
    final docTuple = await getDocument();

    if (docTuple.item1.exists) {
      await docTuple.item2.update({
        'todos': FieldValue.arrayUnion([
          {
            'id': todo.id,
            'title': todo.title,
            'completed': todo.completed,
          },
        ]),
      });
    } else {
      await docTuple.item2.set({
        'todos': [
          {
            'id': todo.id,
            'title': todo.title,
            'completed': todo.completed,
          },
        ],
      });
    }
  }

  Future<void> toggleTodo(String id) async {
    final docTuple = await getDocument();

    if (docTuple.item1.exists) {
      final todos = (docTuple.item1.data()!['todos'] as List<dynamic>)
          .map((e) => TodoState.fromMap(e as Map<String, dynamic>))
          .toList();

      final todo = todos.firstWhere((todo) => todo.id == id);
      final index = todos.indexWhere((todo) => todo.id == id);

      todos[index] = todo.copyWith(
        id: todo.id!,
        title: todo.title!,
        completed: !todo.completed,
      );

      await docTuple.item2.update({
        'todos': todos.map((todo) => todo.toMap()).toList(),
      });
    }
  }

  Future<List<TodoState>> retrieveTodos() async {
    final docTuple = await getDocument();

    if (docTuple.item1.exists) {
      final todos = docTuple.item1.data()!['todos'] as List<dynamic>;
      return todos
          .map((todo) => TodoState.fromMap(todo as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> removeTodo(String id) async {
    final docTuple = await getDocument();

    if (docTuple.item1.exists) {
      final todos = (docTuple.item1.data()!['todos'] as List<dynamic>)
          .map((e) => TodoState.fromMap(e as Map<String, dynamic>))
          .toList();

      final index = todos.indexWhere((todo) => todo.id == id);

      todos.removeAt(index);

      await docTuple.item2.update({
        'todos': todos.map((todo) => todo.toMap()).toList(),
      });
    }
  }
}
