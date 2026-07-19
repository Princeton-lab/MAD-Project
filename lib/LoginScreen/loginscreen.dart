// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.inventory_2, size: 50, color: Colors.white),
        ),
          Text(
          'WELCOME BACK!',
           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
          Text(
          'Please log in to continue',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Padding(
        padding:  const EdgeInsets.all(20),
        child: Column(
          children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.lock_outlined),
            suffixIcon: IconButton (
              icon: Icon (
            _obscurePassword
            ?Icons.visibility_off_outlined
            :Icons.visibility_outlined),
            
             onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
            ),
          ),
          
        ),
        ])
        ),
         SizedBox(height: 10),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),

        const SizedBox(height: 20),

     SizedBox(
  width: 200,
  height: 50,
  child: FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      padding: const EdgeInsets.all(15),
    ),
    onPressed: () async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    User? user = FirebaseAuth.instance.currentUser;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
        print(doc.exists);
        print(doc.data());

    String role = doc['role'];

    if (role == "admin") {
      print("ADMIN DETECTED");
      Navigator.pushNamed(context, '/adminpage');
    } else {
      print("STAFF DETECTED");
      Navigator.pushNamed(context, '/homepage');
    }
  } on FirebaseAuthException catch (e) {
    String message = "Login failed";

    if (e.code == 'user-not-found') {
      message = "No user found with that email.";
    } else if (e.code == 'wrong-password') {
      message = "Incorrect password.";
    } else if (e.code == 'invalid-credential') {
      message = "Invalid email or password.";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
},
    child: const Text("Login"),
  ),
),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? "),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
  }
}