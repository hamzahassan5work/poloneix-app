import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/config/firebase/firebase_options.dart';
import 'package:poloniex_app/core/routes/router.dart';
import 'package:poloniex_app/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Poloniex App',
      theme: AppThemes.light,
      
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouter().router.routeInformationParser,
      routeInformationProvider: AppRouter().router.routeInformationProvider,
      routerDelegate: AppRouter().router.routerDelegate,
    );
  }
}

