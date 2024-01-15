import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poloniex_app/core/constants/colors.dart';
import 'package:poloniex_app/core/constants/dimentions.dart';
import 'package:poloniex_app/core/extensions/ui_extensions.dart';
import 'package:poloniex_app/core/shared/providers/core_providers.dart';
import 'package:poloniex_app/core/shared/widgets/app_text_form_field.dart';
import 'package:poloniex_app/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:poloniex_app/features/trade/presentation/controllers/trade_controller.dart';
import 'package:poloniex_app/features/trade/presentation/widgets/live_chart_widget.dart';

class TradeScreen extends ConsumerStatefulWidget {
  const TradeScreen({super.key});

  @override
  ConsumerState<TradeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<TradeScreen> {
  void _onSignOutPressed() {
    ref.read(signOutControllerProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      signOutControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );
    final user = ref.watch(userProvider);
    final btcCurrentPrice = ref.watch(assetLatestPriceProvider);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: _onSignOutPressed,
                icon: const Icon(Icons.logout),
              ),
            ],
            title: const _DepositFieldWidget(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacerH8,
                  Text('Welcome, ${user?.name ?? ''}'),
                  spacerH8,
                  const SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: _PortfolioValueWidget(),
                      ),
                    ),
                  ),
                  spacerH12,
                  Text(
                    'BTC/USDT \$${btcCurrentPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  spacerH16,
                  const LiveLineChart(),
                ],
              ),
            ),
          ),
        ),
        Consumer(builder: (context, ref, _) {
          final state = ref.watch(tradeStreamControllerProvider);
          return state.when(
            data: (value) => const SizedBox.shrink(),
            loading: () => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const SpinKitPulsingGrid(
                    color: AppColors.primary,
                    size: 50.0,
                  ),
                  Positioned(
                    bottom: MediaQuery.paddingOf(context).bottom + 24,
                    child: Material(
                      child: Text(
                        'Loading...',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.primary,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            error: (error, stackTrace) => const SizedBox(),
          );
        }),
      ],
    );
  }
}

final assetLatestPriceProvider = StateProvider<double>((ref) {
  final value = ref.watch(tradeStreamControllerProvider);
  return value.value ?? 0;
});

class _DepositFieldWidget extends ConsumerStatefulWidget {
  const _DepositFieldWidget();

  @override
  ConsumerState<_DepositFieldWidget> createState() =>
      _DepositFieldWidgetState();
}

class _DepositFieldWidgetState extends ConsumerState<_DepositFieldWidget> {
  final _controller = TextEditingController();
  void _onDepositPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    final deposit = _controller.text;
    if (deposit.isEmpty && double.tryParse(deposit) == null) {
      return;
    }
    _controller.clear();
    ref.read(_initialDepositProvider.notifier).state = double.parse(deposit);
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      controller: _controller,
      label: 'Portfolio Value',
      suffixIcon: TextButton(
          onPressed: _onDepositPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: const Text('Deposit')),
    );
  }
}

class _PortfolioValueWidget extends ConsumerWidget {
  const _PortfolioValueWidget({
    super.key,
  });

  Widget _getProfitAndPercentageText(
      double initialDeposit, double btcCurrentPrice, BuildContext context) {
    String text = '';
    double profit = 0;
    if (initialDeposit <= 0) {
      text = '\$0.0 (0.00%)';
    } else {
      profit = btcCurrentPrice - initialDeposit;
      final profitPercentage = profit / initialDeposit * 100;
      final profitStr =
          '${profit >= 0 ? '+' : '-'}\$${profit.abs().toStringAsFixed(1)}';
      final profitPercentageStr =
          '(${profitPercentage >= 0 ? '+' : '-'}${profitPercentage.abs().toStringAsFixed(2)}%)';
      text = '$profitStr$profitPercentageStr';
    }

    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: switch (profit) {
                  == 0 => Colors.grey.shade600,
                  > 0 => Colors.green.shade600,
                  _ => Colors.red.shade600,
                },
                fontWeight: FontWeight.w500,
              ),
        ),
        Icon(
          switch (profit) {
            == 0 => Icons.remove,
            > 0 => Icons.arrow_drop_up,
            _ => Icons.arrow_drop_down,
          },
          color: switch (profit) {
            == 0 => Colors.grey.shade600,
            > 0 => Colors.green.shade600,
            _ => Colors.red.shade600,
          },
          size: 20,
        ),
      ],
    );
    // );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final btcCurrentPrice = ref.watch(assetLatestPriceProvider);

    final initialDeposit = ref.watch(_initialDepositProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Balance',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        spacerH4,
        Text(
          '\$${initialDeposit.toStringAsFixed(2)}',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            _getProfitAndPercentageText(
                initialDeposit, btcCurrentPrice, context),
          ],
        ),
      ],
    );
  }
}

final _initialDepositProvider = StateProvider<double>((ref) {
  return 0;
});
