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
              'id': 1234,
              'name': 'Run an app',
              'category': 'Development 👨‍💻',
              'when': mocWhenDate.toIso8601String(),
            },
          ),
          isA<Todo>()
              .having((w) => w.id, 'id', 1234)
              .having((w) => w.name, 'name', 'Run an app')
              .having((w) => w.category, 'category', 'Development 👨‍💻')
              .having((w) => w.when, 'when', mocWhenDate),
        );
      });
    });
  });
}
