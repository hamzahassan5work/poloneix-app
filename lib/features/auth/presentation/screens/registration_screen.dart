import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/constants/dimentions.dart';
import 'package:poloniex_app/core/extensions/ui_extensions.dart';
import 'package:poloniex_app/core/shared/widgets/app_text_form_field.dart';
import 'package:poloniex_app/core/utils/utils.dart';
import 'package:poloniex_app/features/auth/presentation/controllers/register_controller.dart';
import 'package:poloniex_app/features/auth/presentation/widgets/auth_filled_button.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onSignUpPressed() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      final fullName =
          '${_firstNameController.text} ${_lastNameController.text}';
      ref.read(registerControllerProvider.notifier).register(
            _emailController.text,
            _passwordController.text,
            fullName.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      registerControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );
    final registerState = ref.watch(registerControllerProvider);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            spacerH8,
            AppTextFormField(
              controller: _emailController,
              validator: (email) {
                if (email?.isEmpty ?? true) {
                  return 'Email is required';
                } else if (!Utils.isEmailValid(email ?? '')) {
                  return 'Invalid email';
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
            spacerH20,
            AppTextFormField(
              controller: _firstNameController,
              validator: (firstName) {
                if (firstName?.isEmpty ?? true) {
                  return 'First name is required';
                }
                return null;
              },
              label: 'First Name',
              type: AppTextFormFieldType.text,
              prefixIcon: const Icon(
                Icons.person_outline,
                size: 20,
              ),
            ),
            spacerH20,
            AppTextFormField(
              controller: _lastNameController,
              validator: (lastName) {
                if (lastName?.isEmpty ?? true) {
                  return 'Last name is required';
                }
                return null;
              },
              label: 'Last Name',
              type: AppTextFormFieldType.text,
              prefixIcon: const Icon(
                Icons.person_outline,
                size: 20,
              ),
            ),
            spacerH20,
            AppTextFormField(
              controller: _passwordController,
              validator: (password) {
                if (password?.isEmpty ?? true) {
                  return 'Password is required';
                }
                if ((password?.length ?? 0) < 8) {
                  return 'Password must be at least 8 characters';
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
            spacerH20,
            AppTextFormField(
              validator: (confirmPassword) {
                if (confirmPassword?.isEmpty ?? true) {
                  return 'Confirm password is required';
                }
                if (confirmPassword != _passwordController.text) {
                  return 'Confirm password does not match';
                }
                return null;
              },
              label: 'Confirm Password',
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
                label: 'Sign Up',
                isLoading: registerState.isLoading,
                onPressed: registerState.isLoading ? null : _onSignUpPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
