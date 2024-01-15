import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/features/auth/data/datasources/auth_network_data_source.dart';
import 'package:poloniex_app/features/auth/domain/models/user_credential_model.dart';
import 'package:poloniex_app/features/auth/domain/models/user_model.dart';

/// Abstract interface class for the authentication repository.
abstract interface class AuthRepository {
  Future<UserCredentialModel> login(String email, String password);
  Future<UserCredentialModel> register(
    String email,
    String password,
    String fullName,
  );
  Future<void> logout();
  UserModel get currentUser;
  bool get isLoggedIn;
}

/// Implementation of the authentication repository.
class _AuthRepositoryImpl implements AuthRepository {
  _AuthRepositoryImpl({required this.authNetworkDataSource});

  final AuthNetworkDataSource authNetworkDataSource;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredentialModel> login(String email, String password) {
    return authNetworkDataSource.login(email, password);
  }

  @override
  Future<void> logout() => authNetworkDataSource.logout();

  @override
  Future<UserCredentialModel> register(
    String email,
    String password,
    String fullName,
  ) {
    return authNetworkDataSource.register(email, password, fullName);
  }

  @override
  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  @override
  UserModel get currentUser => authNetworkDataSource.currentUser;
}

/// Provider for the [AuthRepository] that provides authentication-related functionality.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => _AuthRepositoryImpl(
    authNetworkDataSource: ref.watch(authNetworkDataSourceProvider),
  ),
);
