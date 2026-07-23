import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// model for one log entry
class ActivityLogEntry {
  final String userId; // whoever made this change
  final String action;
  final DateTime timestamp;

  ActivityLogEntry({
    required this.userId,
    required this.action,
    required this.timestamp,
  });

  factory ActivityLogEntry.fromFirestore(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Timestamp ts = data['Timestamp'] ?? Timestamp.now();

    return ActivityLogEntry(
      userId: data['UserId'] ?? '',
      action: data['Action'] ?? '',
      timestamp: ts.toDate(),
    );
  }

  // turns the Firestore timestamp into something like "May 21, 2024 2:30 PM"
  String get formattedTimestamp {
    List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    String month = months[timestamp.month - 1];
    int day = timestamp.day;
    int year = timestamp.year;

    int hour = timestamp.hour % 12;
    if (hour == 0) {
      hour = 12;
    }

    String minute = timestamp.minute.toString().padLeft(2, '0');

    String period = "AM";
    if (timestamp.hour >= 12) {
      period = "PM";
    }

    return month + " " + day.toString() + ", " + year.toString() + " " +
        hour.toString() + ":" + minute + " " + period;
  }
}

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Activity Log",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // listens to ActivityLog live, newest first
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ActivityLog')
            .orderBy('Timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.hasData == false || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No activity yet.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          List<ActivityLogEntry> activityLog = [];
          for (var doc in snapshot.data!.docs) {
            activityLog.add(ActivityLogEntry.fromFirestore(doc));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: activityLog.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return _buildLogTile(activityLog[index]);
            },
          );
        },
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
            IconButton(
              color: Colors.white,
              tooltip: 'Open item details',
              icon: const Icon(Icons.list_alt),
              onPressed: () {
                Navigator.pushNamed(context, '/itemdetails');
              },
            ),
            IconButton(
              color: Colors.white,
              tooltip: 'Open alert screen',
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.pushNamed(context, '/alertpage');
              },
            ),
            IconButton(
              color: Colors.red,
              tooltip: 'Open log screen',
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.pushNamed(context, '/logpage');
              },
            ),
            IconButton(
              color: Colors.white,
              tooltip: 'Open profile screen',
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profilepage');
              },
            ),
          ],
        ),
      ),
    );
  }

  // builds one row - avatar, role, action, timestamp
  // each row has to check the DB for its own userId's role since
  // different rows can belong to different people
  Widget _buildLogTile(ActivityLogEntry entry) {
    return FutureBuilder<DocumentSnapshot>(
      future: _getUserDocument(entry.userId),
      builder: (context, userSnapshot) {
        String roleDisplay = "Loading...";
        Color roleColor = Colors.grey; // default while still loading

        if (userSnapshot.connectionState == ConnectionState.done) {
          if (userSnapshot.hasData == false) {
            roleDisplay = "Unknown";
            roleColor = Colors.grey;
          } else if (userSnapshot.data!.exists == false) {
            roleDisplay = "Unknown";
            roleColor = Colors.grey;
          } else {
            Map<String, dynamic> userData =
                userSnapshot.data!.data() as Map<String, dynamic>;

            String role = userData['role'] ?? 'Unknown';

            // capitalize first letter, eg staff -> Staff
            if (role.isNotEmpty) {
              String firstLetter = role[0].toUpperCase();
              String restOfWord = role.substring(1);
              roleDisplay = firstLetter + restOfWord;
            } else {
              roleDisplay = role;
            }

            // give each role its own fixed color, so admin and staff
            // never end up looking the same by coincidence
            roleColor = _colorForRole(role);
          }
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: roleColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roleDisplay,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.action,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.formattedTimestamp,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // gives admin and staff their own fixed colors, so they're always
  // different, no matter what their uid happens to hash to
  Color _colorForRole(String role) {
    String roleLower = role.toLowerCase();

    if (roleLower == "admin") {
      return const Color(0xFFA8D8B9); // green
    } else if (roleLower == "staff") {
      return const Color(0xFFA6C8F3); // blue
    } else {
      return Colors.grey;
    }
  }

  // grabs the user doc for a given uid from the users collection
  Future<DocumentSnapshot> _getUserDocument(String userId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    return userDoc;
  }
}