// test/utils_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:poloniex_app/core/utils/utils.dart';

void main() {
  group('Utils', () {
    test('valid email returns true', () {
      // Arrange
      const email = 'test@example.com';

      // Act
      final result = Utils.isEmailValid(email);

      // Assert
      expect(result, isTrue);
    });

    test('invalid email returns false', () {
      // Arrange
      const email = 'invalid-email';

      // Act
      final result = Utils.isEmailValid(email);

      // Assert
      expect(result, isFalse);
    });

    test('empty email returns false', () {
      // Arrange
      const email = '';

      // Act
      final result = Utils.isEmailValid(email);

      // Assert
      expect(result, isFalse);
    });

    test('null email returns false', () {
      // Arrange
      const email = null;

      // Act
      final result = Utils.isEmailValid(email);

      // Assert
      expect(result, isFalse);
    });

    test('email with spaces returns false', () {
      // Arrange
      const email = 'test @ example.com';

      // Act
      final result = Utils.isEmailValid(email);

      // Assert
      expect(result, isFalse);
    });

  });
}
