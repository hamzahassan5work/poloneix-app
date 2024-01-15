import 'package:dio/dio.dart';
import 'package:poloniex_app/core/network/rest_endpoints.dart';
import 'package:poloniex_app/features/trade/domain/models/connection_success_response_model.dart';
import 'package:retrofit/http.dart';

part 'rest_api.g.dart';

/// An abstract class representing a REST API.
///
/// This class provides methods for making REST API calls.
@RestApi()
abstract class RestAPI {
  factory RestAPI(Dio dio, {String baseUrl}) = _RestAPI;

  @POST(KRestEndpoint.bulletPublic)
  Future<ConnectionSuccessResponseModel> webSocketConnectionRequest();
}
