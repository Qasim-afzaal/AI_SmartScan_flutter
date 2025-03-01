import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String email;
  final DateTime? createdAt;

  AppUser({
    required this.uid,
    required this.email,
    this.createdAt,
  });

  factory AppUser.fromFirebase(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      createdAt: user.metadata.creationTime,
    );
  }
}