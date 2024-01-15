// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credential_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialModel _$UserCredentialModelFromJson(Map<String, dynamic> json) =>
    UserCredentialModel(
      authCredential: AuthCredentialModel.fromJson(
          json['authCredential'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCredentialModelToJson(
        UserCredentialModel instance) =>
    <String, dynamic>{
      'authCredential': instance.authCredential,
      'user': instance.user,
    };
