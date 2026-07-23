import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
    IconData getItemIcon(String category) {
  switch (category) {
    case "Electronics":
      return Icons.laptop;

    case "Stationery":
      return Icons.edit;

    case "Cleaning":
      return Icons.cleaning_services;
    
    case "Accessory":
      return Icons.mouse;

    case "Furniture":
      return Icons.chair;

    default:
      return Icons.inventory_2;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
       AppBar(title:  Text('Stock Screen'),
      ),
body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Items')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              bool lowStock =
                  item['Quantity'] <= item['Minimum Stock'];
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                elevation: 2,
                child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/itemdetails',
                  arguments: item,);
                },

                child: ListTile(
                  leading: Icon(
                    getItemIcon(item['Category']),
                    size: 40,
                    color: Colors.deepPurple,
                  ),

                  title: Text(
                    item['Item Name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    "${item['Category']}\nQty: ${item['Quantity']}",
                  ),
              
                  trailing: Container(
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
                      style: TextStyle(
                        color:
                            lowStock ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ),
              );
            },
          );
        },
      ),
      

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pushNamed(context, '/AddScreen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}