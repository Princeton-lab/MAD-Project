import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registerdata {
  static Future<void> addInfo(String email, String password) async {
    // Create user in Firebase Authentication
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Save additional user data in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user!.uid)
        .set({
      'email': email,
      'role': 'staff',
      'createdAt': Timestamp.now(),
    });
  }
}
