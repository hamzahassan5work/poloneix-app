// This file will be used to store all the providers that are used by multiple features

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/features/auth/domain/models/user_model.dart';

/// [userProvider] is used to store the user credentials after login
/// or registration. It will be null if the user is not logged in.
final userProvider = StateProvider<UserModel?>((ref) {
  return null;
});

final authStateProvider = StreamProvider<User?>((ref) async* {
  yield* FirebaseAuth.instance.authStateChanges()
    ..listen((user) {
      ref.read(userProvider.notifier).state = UserModel(
        uid: user?.uid ?? '',
        email: user?.email ?? '',
        name: user?.displayName ?? '',
      );
    });
});
