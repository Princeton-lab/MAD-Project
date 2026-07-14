import 'package:flutter/material.dart';
// Data model for one activity log entry
class ActivityLogEntry {
  final String userName;
  final String action; // e.g. "Edited Logitech Keyboard"
  final String timestamp; // e.g. "May 21, 2024 2:30 PM"
  final Color avatarColor;

  ActivityLogEntry({
    required this.userName,
    required this.action,
    required this.timestamp,
    required this.avatarColor,
  });
}

// 1 - Hardcoded activity log for now. Later this gets replaced with a
//     Firestore query (Topic 6), ordered by timestamp descending.
final List<ActivityLogEntry> _activityLog = [
  ActivityLogEntry(
    userName: "John Doe",
    action: "Edited Logitech Keyboard",
    timestamp: "May 21, 2024 2:30 PM",
    avatarColor: const Color(0xFFD9A5E0),
  ),
  ActivityLogEntry(
    userName: "Jane Smith",
    action: "Added A4 Bond Paper",
    timestamp: "May 21, 2024 11:15 AM",
    avatarColor: const Color(0xFFA8D8B9),
  ),
  ActivityLogEntry(
    userName: "John Doe",
    action: "Deleted Old Mouse",
    timestamp: "May 20, 2024 4:45 PM",
    avatarColor: const Color(0xFFF3A6A6),
  ),
  ActivityLogEntry(
    userName: "Jane Smith",
    action: "Edited Detergent Powder",
    timestamp: "May 20, 2024 9:30 AM",
    avatarColor: const Color(0xFFF3A6A6),
  ),
  ActivityLogEntry(
    userName: "John Doe",
    action: "Added USB Cable",
    timestamp: "May 19, 2024 3:10 PM",
    avatarColor: const Color(0xFFA6C8F3),
  ),
];

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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _activityLog.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return _buildLogTile(_activityLog[index]);
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
              // Highlighted since this is the current screen
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
        // Name / action / timestamp
        Expanded( //make widget take up all the remaining space in the row
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
                entry.timestamp,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}