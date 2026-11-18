import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../auth/repository/auth_repository.dart';

/// The main dashboard screen for the application.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch real-time user data from Firestore
    final userDataAsync = ref.watch(userDataProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        title: const Text(AppStrings.appName, style: TextStyle(color: AppColors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.white),
            tooltip: AppStrings.logoutText,
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: userDataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: AppColors.errorRed))),
        data: (user) {
          if (user == null) return const Center(child: Text('User data not found'));

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Greeting & Profile Header
                  Text(
                    '${AppStrings.homeGreeting.split(',')[0]}, ${user.name}!', // e.g. "Hello, Piash!"
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppStrings.levelText}${user.level}',
                    style: const TextStyle(fontSize: 16, color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 32),

                  // Stats Row (XP & Streak)
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          title: AppStrings.totalXp,
                          value: user.totalXP.toString(),
                          icon: Icons.star_rounded,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          title: AppStrings.currentStreak,
                          value: '${user.currentStreak} Days',
                          icon: Icons.local_fire_department_rounded,
                          color: AppColors.errorRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Action Buttons
                  _buildActionCard(
                    title: AppStrings.practiceSpeaking,
                    icon: Icons.mic_rounded,
                    color: AppColors.primaryBlue,
                    onTap: () {
                      context.push('/speaking'); // Navigation to Speaking Screen
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    title: AppStrings.learnVocabulary,
                    icon: Icons.menu_book_rounded,
                    color: AppColors.successGreen,
                    onTap: () {
                      // TODO: Navigate to Vocabulary Module
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Helper widget to build stat cards (XP, Streak)
  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  /// Helper widget to build large action buttons
  Widget _buildActionCard({required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), radius: 24, child: Icon(icon, color: color, size: 28)),
            const SizedBox(width: 20),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}