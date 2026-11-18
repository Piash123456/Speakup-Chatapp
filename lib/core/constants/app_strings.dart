/// Centralized string resources for the SpeakUp application.
class AppStrings {
  // Prevent instantiation
  AppStrings._();

  // App Level
  static const String appName = 'SpeakUp';
  
  // Onboarding & Auth
  static const String welcomeTitle = 'Improve Your English';
  static const String welcomeSubtitle = 'Practice speaking with AI everyday.';
  static const String loginButtonText = 'Login';
  static const String signupButtonText = 'Sign Up';
  
  // Errors
  static const String networkError = 'Please check your internet connection.';
  static const String generalError = 'Something went wrong. Please try again.';

  // Onboarding
  static const String obTitle2 = 'Master Grammar';
  static const String obSub2 = 'Get real-time AI corrections and explanations in Bangla.';
  static const String getStartedBtn = 'Get Started';
  static const String nextBtn = 'Next';


  // Authentication
  static const String loginTitle = 'Welcome Back!';
  static const String loginSub = 'Sign in to continue your learning journey.';
  static const String emailHint = 'Email Address';
  static const String passwordHint = 'Password';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signupText = "Sign Up";
  static const String loggingIn = "Logging in...";

  // Sign Up
  static const String signupTitle = 'Create Account';
  static const String signupSub = 'Start your English learning journey today.';
  static const String nameHint = 'Full Name';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String loginText = 'Login';
  static const String creatingAccount = 'Creating account...';


  // Home Dashboard
  static const String homeGreeting = 'Hello, Learner!';
  static const String dailyGoal = 'Daily Goal';
  static const String currentStreak = 'Current Streak';
  static const String totalXp = 'Total XP';
  static const String logoutText = 'Log Out';

  // Dashboard Actions
  static const String practiceSpeaking = 'Practice Speaking';
  static const String learnVocabulary = 'Learn Vocabulary';
  static const String levelText = 'Level: ';

  // Speaking Practice
  static const String speakingTitle = 'Speaking Practice';
  static const String aiGreeting = 'Hello! I am your AI English tutor. What would you like to talk about today?';
  static const String typeMessageHint = 'Type your message...';
}