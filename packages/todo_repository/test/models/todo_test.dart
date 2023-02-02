import 'package:test/test.dart';
import 'package:todo_repository/todo_repository.dart';

void main() {
  group('Weather', () {
    test('can be (de)serialized', () {
      final todo = Todo(
        id: 1234,
        title: 'Work',
        category: 'Funny things 😂',
        when: DateTime.now(),
      );
      expect(Todo.fromJson(todo.toJson()), equals(todo));
    });
  });
}
