import 'package:flutter_test/flutter_test.dart';
import 'package:poloniex_app/core/config/app/app_config.dart';

void main() {
  test('AppConfig returns the correct baseUrl for staging environment', () {
    final config = AppConfig();
    expect(config.baseUrl, 'https://futures-api.poloniex.com/api/');
  });

  test('AppConfig returns the correct baseUrl for production environment', () {
    final config = AppConfig.prod();
    expect(config.baseUrl, 'https://futures-api.poloniex.com/api/');
  });

  test('AppConfig returns the correct baseUrl for default environment', () {
    final config = AppConfig.dev();
    expect(config.baseUrl, 'https://futures-api.poloniex.com/api/');
  });
}
