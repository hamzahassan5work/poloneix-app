import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/features/auth/data/repositories/auth_repository.dart';
import 'package:poloniex_app/features/auth/domain/models/user_credential_model.dart';

class _LoginController extends AutoDisposeAsyncNotifier<UserCredentialModel?> {
  @override
  FutureOr<UserCredentialModel?> build() => null;

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(email, password),
    );
  }
}

/// Provider for the [_LoginController] instance.
///
/// This provider is responsible for managing the login controller, which handles the authentication process.
/// It provides an [AsyncNotifierProvider] that allows accessing the [_LoginController] instance and the user credential model.
final loginControllerProvider =
    AsyncNotifierProvider.autoDispose<_LoginController, UserCredentialModel?>(
  _LoginController.new,
);
