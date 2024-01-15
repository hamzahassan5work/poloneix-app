import 'package:poloniex_app/core/enums/enums.dart';

/// The configuration class for the application.
class AppConfig {
  factory AppConfig() => _instance;

  static final AppConfig _instance = AppConfig._();

  AppConfig._() : _environment = Environment.staging;

  /// Creates an instance of [AppConfig] with the development environment.
  AppConfig.dev() : _environment = Environment.staging;

  /// Creates an instance of [AppConfig] with the production environment.
  AppConfig.prod() : _environment = Environment.production;

  final Environment _environment;
  final String _baseUrlStaging = 'https://futures-api.poloniex.com/api/';
  final String _baseUrlProduction = 'https://futures-api.poloniex.com/api/';

  /// Returns the base URL based on the current environment.
  String get baseUrl {
    switch (_environment) {
      case Environment.staging:
        return _baseUrlStaging;
      case Environment.production:
        return _baseUrlProduction;
      default:
        return _baseUrlStaging;
    }
  }
}
