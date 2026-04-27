import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

  static const String _baseUrl = String.fromEnvironment("API_URL");

  Future<UserCredential?> signUp(
    String email,
    String password,
    String username,
    String fullName,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? token = await credential.user?.getIdToken();

      if (token == null) throw Exception("Failed to get token");

      final response = await http.post(
        Uri.parse("$_baseUrl/register"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'username': username.toLowerCase(),
          'fullName': fullName,
          'email': email,
        }),
      );

      if (response.statusCode == 201) {
        return credential;
      } else {
        await credential.user?.delete();
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>?;
    }

    return null;
  }

  User? get currentUser => _auth.currentUser;
}
