import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/shared/providers/core_providers.dart';
import 'package:poloniex_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:poloniex_app/features/trade/presentation/screens/trade_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);
    return Scaffold(
      body: userAsync.when(
        data: (user) => user == null ? const AuthScreen() : const TradeScreen(),
        error: (_, __) => null,
        loading: () => null,
      ),
    );
  }
}
