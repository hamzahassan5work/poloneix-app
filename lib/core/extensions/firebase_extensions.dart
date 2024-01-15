import 'package:firebase_auth/firebase_auth.dart';
import 'package:poloniex_app/core/constants/strings.dart';
import 'package:poloniex_app/core/network/exceptions/auth_exception.dart';
import 'package:poloniex_app/features/auth/domain/models/auth_credential_model.dart';
import 'package:poloniex_app/features/auth/domain/models/user_credential_model.dart';
import 'package:poloniex_app/features/auth/domain/models/user_model.dart';

/// Extension on [FirebaseAuthException] to provide additional functionality.
extension FirebaseAuthExceptionExtension on FirebaseAuthException {
  /// Returns an [AuthException] based on the [code] of the [FirebaseAuthException].
  AuthException get authException {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return AuthException(KStrings.invalidCredentials);
      case 'email-already-in-use':
        return AuthException(KStrings.emailAlreadyInUse);
      case 'invalid-email':
        return AuthException(KStrings.invalidEmail);
      case 'weak-password':
        return AuthException(KStrings.weakPassword);
      case 'user-not-found':
        return AuthException(KStrings.userNotFound);
      case 'wrong-password':
        return AuthException(KStrings.wrongPassword);
      default:
        return AuthException(code);
    }
  }
}

/// Extension on [UserCredential] to provide a convenient way to convert it to [UserCredentialModel].
extension FirebaseUserCredentialExtension on UserCredential {
  /// Converts [UserCredential] to [UserCredentialModel].
  UserCredentialModel get userCredentialModel {
    return UserCredentialModel(
      authCredential: AuthCredentialModel(
        token: credential?.accessToken ?? '',
      ),
      user: UserModel(
        uid: user?.uid ?? '',
        email: user?.email ?? '',
        name: user?.displayName ?? '',
      ),
    );
  }
}
