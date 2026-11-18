import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_model.dart';

/// Provider for the AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
});

/// StreamProvider to listen to authentication state changes (This was missing)
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChanges;
});

/// StreamProvider to listen to real-time user profile updates from Firestore.
final userDataProvider = StreamProvider<UserModel?>((ref) {
  // 1. Get the current authenticated user
  final authState = ref.watch(authStateProvider);
  final user = authState.value;

  // 2. If nobody is logged in, return null
  if (user == null) return Stream.value(null);

  // 3. Listen to the specific user's document in Firestore
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('users').doc(user.uid).snapshots().map((snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      return UserModel.fromMap(snapshot.data()!);
    }
    return null;
  });
});

/// Handles all authentication and user creation logic.
class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._auth, this._firestore);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Logs in a user with email and password
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Authentication failed');
    }
  }

  /// Registers a new user and saves their profile to Firestore
  Future<UserCredential> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      
      // 2. Save initial user data to Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'level': 'A1', // Default beginner level
          'totalXP': 0,
          'currentStreak': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registration failed');
    }
  }

  /// Logs out the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}