import 'package:flutter/material.dart';

class InventoryItem {
  final String name;
  final String category;
  final int quantity;
  final int threshold;
  final IconData icon; // placeholder for a product image
 
  InventoryItem({
    required this.name,
    required this.category,
    required this.quantity,
    required this.threshold,
    required this.icon,
  });
 
  bool get isLowStock => quantity <= threshold;
}

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  
  // 1 - Hardcoded list for now. In final app replaced with a Firestore query (Topic 6) filtered where quantity <= threshold.
  //     Firestore query (Topic 6) filtered where quantity <= threshold.
  final List<InventoryItem> _lowStockItems = [
    InventoryItem(
      name: "Logitech Keyboard",
      category: "Electronics",
      quantity: 3,
      threshold: 5,
      icon: Icons.keyboard, //missing icon, but using keyboard as placeholder
    ),
    InventoryItem(
      name: "Detergent Powder",
      category: "Cleaning",
      quantity: 2,
      threshold: 5,
      icon: Icons.local_laundry_service, //missing icon, but using laundry service as placeholder
    ),
    InventoryItem(
      name: "USB Cable",
      category: "Electronics",
      quantity: 1,
      threshold: 10,
      icon: Icons.cable, //missing icon, but using cable as placeholder
    ),
    InventoryItem(
      name: "Permanent Marker",
      category: "Stationery",
      quantity: 2,
      threshold: 10,
      icon: Icons.edit, //missing icon, but using edit as placeholder
    ),
  ];

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
          "Low Stock Alerts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Hook up a filter dialog here later (Topic 5 - Dialog)
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildWarningBanner(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _lowStockItems.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return _buildAlertTile(_lowStockItems[index]);
              },
            ),
          ),
        ],
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
              // Highlighted since this is the current screen
              color: Colors.red,
              tooltip: 'Open alert screen',
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.pushNamed(context, '/alertpage');
              },
            ),
            IconButton(
              color: Colors.white,
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

  //reuseable widget for each alert item in the list
  Widget _buildWarningBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4E4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "These items are below their set threshold. Please reorder as soon as possible.",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  //row widget for each alert item in the list
  Widget _buildAlertTile(InventoryItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Product "image" placeholder
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, color: Colors.black54),
          ),
          const SizedBox(width: 12),
          // Name / category / qty
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.category,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  "Qty: ${item.quantity} / Threshold: ${item.threshold}",
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          // "Low Stock" badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE4E4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Low Stock",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}