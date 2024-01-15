// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_success_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionSuccessResponseModel _$ConnectionSuccessResponseModelFromJson(
        Map<String, dynamic> json) =>
    ConnectionSuccessResponseModel(
      code: json['code'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectionSuccessResponseModelToJson(
        ConnectionSuccessResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      instanceServers: (json['instanceServers'] as List<dynamic>)
          .map((e) => InstanceServer.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'instanceServers': instance.instanceServers,
      'token': instance.token,
    };

InstanceServer _$InstanceServerFromJson(Map<String, dynamic> json) =>
    InstanceServer(
      pingInterval: json['pingInterval'] as int,
      endpoint: json['endpoint'] as String,
      protocol: json['protocol'] as String,
      encrypt: json['encrypt'] as bool,
      pingTimeout: json['pingTimeout'] as int,
    );

Map<String, dynamic> _$InstanceServerToJson(InstanceServer instance) =>
    <String, dynamic>{
      'pingInterval': instance.pingInterval,
      'endpoint': instance.endpoint,
      'protocol': instance.protocol,
      'encrypt': instance.encrypt,
      'pingTimeout': instance.pingTimeout,
    };
