import 'package:go_router/go_router.dart';
import '../../../core/local_storage/cache_manager.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// Initial screen displayed when the app launches.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  /// Handles the delay and routing logic after splash.
  Future<void> _navigateToNextScreen() async {
    // Artificial delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    if(!mounted) return;

    final bool isFirstTime = CacheManager.getBool('isFirstTime', defaultValue: true);
    if(isFirstTime){
      // Show onboarding only for the first time
      context.go('/onboarding');
    }
    else{
      // If onboarding is already completed, go directly to login
      context.go('/login');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Center(
        child: Text(
          AppStrings.appName,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}