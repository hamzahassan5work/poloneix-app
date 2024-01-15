import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/constants/dimentions.dart';
import 'package:poloniex_app/core/extensions/ui_extensions.dart';
import 'package:poloniex_app/core/shared/widgets/app_text_form_field.dart';
import 'package:poloniex_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:poloniex_app/features/auth/presentation/widgets/auth_filled_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(loginControllerProvider.notifier).login(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      loginControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );
    final loginState = ref.watch(loginControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          spacerH8,
          AppTextFormField(
            controller: _emailController,
            validator: (email) {
              if (email?.isEmpty ?? true) {
                return 'Email is required';
              }
              return null;
            },
            label: 'Email',
            type: AppTextFormFieldType.email,
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: 20,
            ),
          ),
          spacerH32,
          AppTextFormField(
            controller: _passwordController,
            validator: (password) {
              if (password?.isEmpty ?? true) {
                return 'Password is required';
              }
              return null;
            },
            label: 'Password',
            type: AppTextFormFieldType.password,
            prefixIcon: const Icon(
              Icons.lock_outline,
              size: 20,
            ),
          ),
          spacerH24,
          SizedBox(
            width: double.infinity,
            child: AuthFilledButton(
              isLoading: loginState.isLoading,
              onPressed: loginState.isLoading ? null : _onLoginPressed,
              label: 'Log In',
            ),
          )
        ],
      ),
    );
  }
}
