import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

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

      await _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'username': username.toLowerCase(),
        'fullName': fullName,
        'email': email,
        'bio': '',
        'photoUrl': '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      return credential;
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
