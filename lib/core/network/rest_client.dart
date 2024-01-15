import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/config/app/app_config.dart';
import 'package:poloniex_app/core/network/http_options.dart';

/// An abstract interface class for an HTTP REST client.
///
/// This interface provides a generic type `T` representing the client.
/// Implementations of this interface should provide a `client` property
/// of type `T` that can be used to make HTTP requests.
abstract interface class RestClient<T> {
  T get client;
}

/// A HTTP client implementation using Dio library.
/// This client is used for making HTTP requests to a server.
class DioClient extends HttpOptions<BaseOptions> implements RestClient<Dio> {
  /// Creates a new instance of [DioClient].
  DioClient()
      : super(
          baseOptions: BaseOptions(
            baseUrl: AppConfig.dev().baseUrl,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
          ),
        );

  @override
  get client => Dio(baseOptions)..interceptors.addAll(getInterceptors);
}

/// Provider for the HTTP REST client using Dio.
final dioClientProvider = Provider<RestClient<Dio>>((_) {
  return DioClient();
});
