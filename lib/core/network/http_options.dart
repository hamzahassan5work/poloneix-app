import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// An abstract class representing the options for a network client.
///
/// The [HttpOptions] class provides a base set of options that can be used by network clients.
/// It contains a [baseOptions] field that holds the base options for the client.
///
/// The [HttpOptions] class also provides a [getInterceptors] getter method that returns a set of interceptors.
/// These interceptors can be used to intercept and modify network requests and responses.
/// The [getInterceptors] method includes a [PrettyDioLogger] interceptor that logs request headers and bodies
/// when the app is running in debug mode.
abstract class HttpOptions<T> {
  final T baseOptions;

  HttpOptions({required this.baseOptions});

  /// Returns a set of interceptors for the network client.
  Set<Interceptor> get getInterceptors => <Interceptor>{}..addAll(
      {
        if (kDebugMode) PrettyDioLogger(requestHeader: true, requestBody: true),
      },
    );
}
