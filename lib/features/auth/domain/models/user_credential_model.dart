import 'package:json_annotation/json_annotation.dart';
import 'package:poloniex_app/features/auth/domain/models/auth_credential_model.dart';
import 'package:poloniex_app/features/auth/domain/models/user_model.dart';

part 'user_credential_model.g.dart';

@JsonSerializable()
class UserCredentialModel {
  final AuthCredentialModel authCredential;
  final UserModel user;

  UserCredentialModel({required this.authCredential, required this.user});

  factory UserCredentialModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialModelToJson(this);
}
