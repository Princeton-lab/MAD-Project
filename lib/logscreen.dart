import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ---------------------------------------------------------------------------
// Data model for one activity log entry
// ---------------------------------------------------------------------------
class ActivityLogEntry {
  final String userName;
  final String action; // e.g. "Edited Logitech Keyboard"
  final DateTime timestamp;
  final Color avatarColor;

  ActivityLogEntry({
    required this.userName,
    required this.action,
    required this.timestamp,
    required this.avatarColor,
  });

  // 1 - Factory constructor: builds an ActivityLogEntry from a Firestore
  //     document. Firestore stores dates as its own "Timestamp" type, so
  //     we convert it to a normal Dart DateTime with .toDate().
  factory ActivityLogEntry.fromFirestore(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final Timestamp ts = data['Timestamp'] ?? Timestamp.now();
    return ActivityLogEntry(
      userName: data['User'] ?? 'Unknown',
      action: data['Action'] ?? '',
      timestamp: ts.toDate(),
      avatarColor: _colorForUser(data['User'] ?? ''),
    );
  }

  // 2 - Firestore doesn't store a color, so we generate a consistent one
  //     per user by cycling through a small fixed palette. Same user
  //     always gets the same color since it's based on their name.
  static const List<Color> _palette = [
    Color(0xFFD9A5E0),
    Color(0xFFA8D8B9),
    Color(0xFFF3A6A6),
    Color(0xFFA6C8F3),
    Color(0xFFF3D9A6),
  ];

  static Color _colorForUser(String userName) {
    if (userName.isEmpty) return _palette[0];
    final index = userName.hashCode % _palette.length;
    return _palette[index.abs()];
  }

  // 3 - Formats the DateTime into something like "May 21, 2024 2:30 PM"
  //     without needing the intl package - just plain Dart.
  String get formattedTimestamp {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final month = months[timestamp.month - 1];
    final day = timestamp.day;
    final year = timestamp.year;

    int hour = timestamp.hour % 12;
    if (hour == 0) hour = 12;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';

    return '$month $day, $year $hour:$minute $period';
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Activity Log",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // 4 - StreamBuilder listens LIVE to the "ActivityLog" collection,
      //     ordered so the most recent activity shows up at the top.
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

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No activity yet.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final List<ActivityLogEntry> activityLog = snapshot.data!.docs
              .map((doc) => ActivityLogEntry.fromFirestore(doc))
              .toList();

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

  // One row: avatar on the left, name/action/timestamp text on the right.
  Widget _buildLogTile(ActivityLogEntry entry) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: entry.avatarColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.userName,
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
  }
}