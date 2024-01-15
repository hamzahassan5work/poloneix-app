import 'package:json_annotation/json_annotation.dart';

part 'connection_success_response_model.g.dart';

@JsonSerializable()
class ConnectionSuccessResponseModel {
  final String code;
  final Data data;

  ConnectionSuccessResponseModel({required this.code, required this.data});

  factory ConnectionSuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectionSuccessResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionSuccessResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final List<InstanceServer> instanceServers;
  final String token;

  Data({required this.instanceServers, required this.token});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class InstanceServer {
  final int pingInterval;
  final String endpoint;
  final String protocol;
  final bool encrypt;
  final int pingTimeout;

  InstanceServer({
    required this.pingInterval,
    required this.endpoint,
    required this.protocol,
    required this.encrypt,
    required this.pingTimeout,
  });

  factory InstanceServer.fromJson(Map<String, dynamic> json) =>
      _$InstanceServerFromJson(json);

  Map<String, dynamic> toJson() => _$InstanceServerToJson(this);
}
