import 'package:hive_flutter/hive_flutter.dart';

/// Manages local storage for offline capabilities using Hive.
class CacheManager {
  // Private constructor to prevent instantiation
  CacheManager._();

  static const String _preferencesBox = 'user_preferences';

  /// Initializes Hive and opens necessary boxes for the app.
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_preferencesBox);
  }

  /// Saves a boolean value (e.g., isFirstTimeOpen).
  static Future<void> saveBool(String key, bool value) async {
    final box = Hive.box(_preferencesBox);
    await box.put(key, value);
  }

  /// Retrieves a boolean value from the cache.
  static bool getBool(String key, {bool defaultValue = false}) {
    final box = Hive.box(_preferencesBox);
    return box.get(key, defaultValue: defaultValue);
  }
  
  /// Clears all stored data (Useful for logout/reset).
  static Future<void> clearAll() async {
    final box = Hive.box(_preferencesBox);
    await box.clear();
  }
}