import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}
Widget detailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Row(
      children: [

        SizedBox(
          width: 150,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: Text(value),
        ),

      ],
    ),
  );
}
class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
     final item =
        ModalRoute.of(context)!.settings.arguments
            as QueryDocumentSnapshot;

  bool lowStock =
    item['Quantity'] <= item['Minimum Stock'];
    return Scaffold(
      appBar: AppBar(
    title: const Text("Item Details"),
  ),

  body: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Image placeholder
        Center(
          child: Container(
            width: 180,
            height: 120,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image, size: 60),
          ),
        ),

        const SizedBox(height: 20),

        // Item name
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              item['Item Name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: lowStock
                    ? Colors.red.shade100
                    : Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                lowStock ? "Low Stock" : "In Stock",
              ),
            ),

          ],
        ),

        const SizedBox(height: 25),

        detailRow("Category", item["Category"]),
        detailRow("Quantity", item["Quantity"].toString()),
        detailRow("Unit Price", "\$${item["Unit Price"]}"),
        detailRow(
          "Low Stock Threshold",
          item["Minimum Stock"].toString(),
        ),
        detailRow("Supplier", item["Supplier"]),

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
          color: Colors.red,
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
          color: Colors.white,
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