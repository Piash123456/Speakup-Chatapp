import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/local_storage/cache_manager.dart';
import 'core/routes/app_router.dart';
import 'core/constants/app_strings.dart';

/// The entry point of the SpeakUp application.
void main() async {
  // Ensure Flutter binding is initialized before calling async native methods
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with auto-generated options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local storage (Hive) for offline support
  await CacheManager.init();

  // Wrap the app with ProviderScope for Riverpod state management
  runApp(const ProviderScope(child: SpeakUpApp()));
}

/// The root widget of the application.
class SpeakUpApp extends StatelessWidget {
  const SpeakUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router, // Connects GoRouter
    );
  }
}