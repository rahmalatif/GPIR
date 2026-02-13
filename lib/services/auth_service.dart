import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref("users");

  Future<void> register(String email, String password, String role) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _db.child(userCredential.user!.uid).set({
      "email": email,
      "role": role,
    });
  }

  Future<User?> login(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return userCredential.user;
  }


  Future<String> getUserRole(String uid) async {
    final snapshot = await _db.child(uid).get();
    return snapshot.child("role").value.toString();
  }
}
