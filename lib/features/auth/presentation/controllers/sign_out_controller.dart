import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/features/auth/data/repositories/auth_repository.dart';


class _SignOutController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() => null;

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).logout(),
    );
  }
}

/// Provider for the [_SignOutController] instance.
///
/// This provider is responsible for managing the login controller, which handles the authentication process.
/// It provides an [AsyncNotifierProvider] that allows accessing the [_SignOutController] instance and the user credential model.
final signOutControllerProvider = AsyncNotifierProvider<_SignOutController, void>(
  _SignOutController.new,
);
