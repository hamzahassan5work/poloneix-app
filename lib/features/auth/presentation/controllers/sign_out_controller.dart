import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/shared/providers/core_providers.dart';
import 'package:poloniex_app/features/auth/data/repositories/auth_repository.dart';
import 'package:poloniex_app/features/trade/presentation/controllers/trade_controller.dart';

class _SignOutController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      ref
        ..invalidate(userProvider)
        ..invalidate(tradeStreamControllerProvider);
    });
    return null;
  }

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
final signOutControllerProvider =
    AsyncNotifierProvider.autoDispose<_SignOutController, void>(
  _SignOutController.new,
);
