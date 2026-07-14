import 'package:flutter/material.dart';
import 'package:project/LoginScreen/registerdataservice.dart';
import 'package:project/LoginScreen/info.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.lock_outlined),
            suffixIcon: Icon(Icons.visibility_off_outlined),
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
    onPressed: () {
      Info? user =
          Registerdata.getInfoByEmail(emailController.text);

      if (user != null &&
          user.password == passwordController.text) {
        Navigator.pushNamed(context, '/homepage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid email or password"),
          ),
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