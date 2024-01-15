import 'package:json_annotation/json_annotation.dart';

part 'auth_credential_model.g.dart';

@JsonSerializable()
class AuthCredentialModel {
  final String token;

  AuthCredentialModel({required this.token});

  factory AuthCredentialModel.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthCredentialModelToJson(this);
}
