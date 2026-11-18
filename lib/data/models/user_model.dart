/// Represents a user profile in the SpeakUp application.
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String level;
  final int totalXP;
  final int currentStreak;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.level,
    required this.totalXP,
    required this.currentStreak,
  });

  /// Creates a UserModel object from a Firestore JSON map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? 'Unknown User',
      email: map['email'] ?? '',
      level: map['level'] ?? 'A1',
      totalXP: map['totalXP']?.toInt() ?? 0,
      currentStreak: map['currentStreak']?.toInt() ?? 0,
    );
  }
}