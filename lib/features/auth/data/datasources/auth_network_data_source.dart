import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/constants/strings.dart';
import 'package:poloniex_app/core/extensions/firebase_extensions.dart';
import 'package:poloniex_app/core/network/exceptions/auth_exception.dart';
import 'package:poloniex_app/features/auth/domain/models/user_credential_model.dart';
import 'package:poloniex_app/features/auth/domain/models/user_model.dart';

// Interface for the authentication network data source
abstract interface class AuthNetworkDataSource {
  Future<UserCredentialModel> login(String email, String password);
  Future<UserCredentialModel> register(
    String email,
    String password,
    String fullName,
  );
  Future<void> logout();
  UserModel get currentUser;
}

// Implementation of the authentication network data source
class AuthNetworkDataSourceImpl implements AuthNetworkDataSource {
  AuthNetworkDataSourceImpl(FirebaseAuth firebaseAuth)
      : _firebaseAuth = firebaseAuth;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserCredentialModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.userCredentialModel;
    } on FirebaseAuthException catch (e) {
      throw e.authException;
    } catch (e) {
      throw AuthException(KStrings.somethingWentWrong);
    }
  }

  @override
  Future<UserCredentialModel> register(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(fullName);
      }

      return userCredential.userCredentialModel;
    } on FirebaseAuthException catch (e) {
      throw e.authException;
    } catch (e) {
      throw AuthException(KStrings.somethingWentWrong);
    }
  }

  @override
  Future<void> logout() async => await _firebaseAuth.signOut();

  @override
  UserModel get currentUser {
    final user = _firebaseAuth.currentUser;
    return UserModel(
      uid: user?.uid ?? '',
      name: user?.displayName ?? '',
      email: user?.email ?? '',
    );
  }
}

/// A provider for the [AuthNetworkDataSource] that creates an instance of [AuthNetworkDataSourceImpl].
final authNetworkDataSourceProvider = Provider<AuthNetworkDataSource>(
  (_) => AuthNetworkDataSourceImpl(FirebaseAuth.instance),
);
