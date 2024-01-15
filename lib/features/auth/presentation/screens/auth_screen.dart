import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/constants/colors.dart';
import 'package:poloniex_app/core/constants/dimentions.dart';
import 'package:poloniex_app/core/utils/screen_utils.dart';
import 'package:poloniex_app/features/auth/presentation/screens/login_screen.dart';
import 'package:poloniex_app/features/auth/presentation/screens/registration_screen.dart';

enum _AuthState {
  login('Log In'),
  register('Sign Up');

  const _AuthState(this.label);

  final String label;
}

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  _AuthState _authState = _AuthState.login;
  final _pageController = PageController(initialPage: 0);
  @override
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedCrossFade(
                      firstChild: Text(
                        'Go ahead and set up\nyour account',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      secondChild: Text(
                        'Create your\naccount',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      crossFadeState: _authState == _AuthState.login
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                    ),
                    spacerH8,
                    Text(
                      'Sign in-up to enjoy the best managing experience',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    spacerH24,
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.paddingOf(context).bottom,
                        ),
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            LoginScreen(),
                            RegistrationScreen(),
                          ],
                        ),
                      ),
                    ),
                    spacerH20,
                    if (!ScreenUtils.isKeyboardVisible(context))
                      Align(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 24,
                            bottom: MediaQuery.paddingOf(context).bottom + 16,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: _authState == _AuthState.login
                                  ? 'Don\'t have an account? '
                                  : 'Already have an account? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        _authState =
                                            _authState == _AuthState.login
                                                ? _AuthState.register
                                                : _AuthState.login;
                                      });
                                      _pageController.animateToPage(
                                        _authState == _AuthState.login ? 0 : 1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                  text: _authState == _AuthState.login
                                      ? 'Sign up'
                                      : 'Log in',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: AppColors.primary,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
