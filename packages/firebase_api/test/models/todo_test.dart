import 'package:firebase_api/firebase_api.dart';
import 'package:test/test.dart';

void main() {
  group('Todo', () {
    group('fromJson', () {
      test('returns correct Todo object', () {
        final mocWhenDate = DateTime.now();
        expect(
          Todo.fromJson(
            <String, dynamic>{
              'id': '1234',
              'name': 'Run an app',
              'categoryId': 'Development 👨‍💻',
              'date': mocWhenDate.toIso8601String(),
            },
          ),
          isA<Todo>()
              .having((w) => w.id, 'id', '1234')
              .having((w) => w.title, 'name', 'Run an app')
              .having((w) => w.category, 'category', 'Development 👨‍💻')
              .having((w) => w.when, 'date', mocWhenDate),
        );
      });
    });
  });
}
