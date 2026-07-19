import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.person,
        size: 100,
      ),
      const SizedBox(height: 20),
      const Text(
        'Profile Screen',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(user?.email ?? "no email"),
      const SizedBox(height: 30),

     ListTile(
      leading: const Icon(Icons.person_outline),
      title: const Text("Account Information"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pushNamed(context, '/accountinfo');
      },
    ),
    const Divider(),

    ListTile(
      leading: const Icon(Icons.lock_outline),
      title: const Text("Change Password"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pushNamed(context, '/changepassword');
      },
    ),
    const Divider(),

    ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text("About App"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pushNamed(context, '/aboutapp');
      },
    ),
    SizedBox(height: 30),
    FilledButton(
      onPressed: () {
        // Handle logout logic here
        Navigator.pushNamed(context, '/loginscreen');
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: const Text(
        'Logout',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
    ],
  ),
),
    bottomNavigationBar: Container(
    padding: const EdgeInsets.all(15),
    color: const Color.fromARGB(255, 185, 176, 202),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: [
      IconButton(
          color: Colors.white,
          tooltip: 'Open home screen',
          icon: const Icon(Icons.home),
       onPressed: () {
        Navigator.pushNamed(context, '/homepage');
       },
      ),
       SizedBox(height: 20),
       IconButton(
          color: Colors.white,
          tooltip: 'Open item details',
          icon: const Icon(Icons.list_alt),
       onPressed: () {
        Navigator.pushNamed(context, '/itemdetails');
       },
      ),
      SizedBox(height: 20),
       IconButton(
          color: Colors.white,
          tooltip: 'Open alert screen',
          icon: const Icon(Icons.notifications),
       onPressed: () {
        Navigator.pushNamed(context, '/alertpage');
       },
      ),
      SizedBox(height: 20),
       IconButton(
          color: Colors.white,
          tooltip: 'Open log screen',
          icon: const Icon(Icons.history),
       onPressed: () {
        Navigator.pushNamed(context, '/logpage');
       },
      ),
      SizedBox(height: 20),
       IconButton(
          color: Colors.red,
          tooltip: 'Open profile screen',
          icon: const Icon(Icons.person),
       onPressed: () {
        Navigator.pushNamed(context, '/profilepage');
       },
      ),
     ]
    )
      )
    );
  }
}