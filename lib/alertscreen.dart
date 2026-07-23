import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------
class InventoryItem {
  final String id; // Firestore document ID - needed later for edit/delete
  final String name;
  final String category;
  final int quantity;
  final int minimumStock;
  final IconData icon;

  InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.minimumStock,
    required this.icon,
  });

  bool get isLowStock => quantity <= minimumStock;

  // 1 - Factory constructor: builds an InventoryItem straight from a
  //     Firestore document. This is where the field-name mapping happens,
  //     matching exactly what's in your Firestore console:
  //     "Item Name", "Category", "Quantity", "Minimum Stock".
  factory InventoryItem.fromFirestore(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InventoryItem(
      id: doc.id,
      name: data['Item Name'] ?? '',
      category: data['Category'] ?? '',
      quantity: data['Quantity'] ?? 0,
      minimumStock: data['Minimum Stock'] ?? 0,
      icon: _iconForCategory(data['Category'] ?? ''),
    );
  }

  // 2 - Firestore has no "icon" field, so we pick one based on category,
  //     matching the same icons your teammate used on the Stock Screen.
  static IconData _iconForCategory(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.laptop;
      case 'Accessory':
        return Icons.mouse;
      default:
        return Icons.inventory_2;
    }
  }
}

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
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
      // 3 - StreamBuilder listens to the "Items" collection LIVE. Every
      //     time a document changes (added/edited/deleted anywhere in the
      //     app), this rebuilds automatically - no manual refresh needed.
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Items').snapshots(),
        builder: (context, snapshot) {
          // Still waiting for the first batch of data from Firestore
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Something went wrong talking to Firestore
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // No documents in the collection at all
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No items found.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // 4 - Convert every Firestore document into an InventoryItem,
          //     then keep only the ones that are low stock.
          final List<InventoryItem> allItems = snapshot.data!.docs
              .map((doc) => InventoryItem.fromFirestore(doc))
              .toList();

          final List<InventoryItem> lowStockItems =
              allItems.where((item) => item.isLowStock).toList();

          return Column(
            children: [
              _buildWarningBanner(),
              Expanded(
                child: lowStockItems.isEmpty
                    ? const Center(
                        child: Text(
                          "No low stock items right now.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: lowStockItems.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return _buildAlertTile(lowStockItems[index]);
                        },
                      ),
              ),
            ],
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
              tooltip: 'Open stock screen',
              icon: const Icon(Icons.list_alt),
              onPressed: () {
                Navigator.pushNamed(context, '/stockpage');
              },
            ),
            IconButton(
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

  Widget _buildAlertTile(InventoryItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
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
                  "Qty: ${item.quantity} / Threshold: ${item.minimumStock}",
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
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