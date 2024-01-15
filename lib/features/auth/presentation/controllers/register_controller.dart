import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/features/auth/data/repositories/auth_repository.dart';
import 'package:poloniex_app/features/auth/domain/models/user_credential_model.dart';

class _RegisterController
    extends AutoDisposeAsyncNotifier<UserCredentialModel?> {
  @override
  FutureOr<UserCredentialModel?> build() => null;

  Future<void> register(String email, String password, String name) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).register(email, password, name),
    );
  }
}

/// Provider for the [_RegisterController] instance.
///
/// This provider is responsible for managing the register controller, which handles the authentication process.
/// It provides an [AsyncNotifierProvider] that allows accessing the [_RegisterController] instance and the user credential model.
final registerControllerProvider = AsyncNotifierProvider.autoDispose<
    _RegisterController, UserCredentialModel?>(
  _RegisterController.new,
);
