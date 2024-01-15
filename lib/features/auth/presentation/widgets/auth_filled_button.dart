import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poloniex_app/core/constants/colors.dart';

class AuthFilledButton extends StatelessWidget {
  const AuthFilledButton({
    super.key,
    this.onPressed,
    required this.label,
    this.isLoading = false,
  });
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: isLoading
          ? const SpinKitWave(
              size: 18,
              color: AppColors.primary,
            )
          : Text(label),
    );
  }
}
