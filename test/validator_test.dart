import 'package:flutter_test/flutter_test.dart';
import 'package:doublevpartnersapp/presentation/components/form/validators.dart';

void main() {
  group('Validators.notEmpty', () {
    test('returns error when value is null', () {
      expect(Validators.notEmpty(null), 'El campo no puede estar vacío');
    });

    test('returns error when value is empty', () {
      expect(Validators.notEmpty('   '), 'El campo no puede estar vacío');
    });

    test('returns null when value has content', () {
      expect(Validators.notEmpty('hola'), isNull);
    });
  });
}
