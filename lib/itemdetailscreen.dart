  import 'package:flutter/material.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  class ItemDetailScreen extends StatefulWidget {
    const ItemDetailScreen({super.key});

    @override
    State<ItemDetailScreen> createState() => _ItemDetailScreenState();
  }
  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,//centers the upcoming children in the row
        children: [

          SizedBox(
            width: 180,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
  SizedBox(
            width: 150,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
<<<<<<< HEAD
          ),
        
        
        ],
      ),
=======

          ],
        ),

        const SizedBox(height: 25),

        detailRow("Category", item["Category"]),
        detailRow("Quantity", item["Quantity"].toString()),
        detailRow("Price", "\$${item["Price"]}"),
        detailRow(
          "Low Stock Threshold",
          item["Minimum Stock"].toString(),
        ),
        detailRow("Supplier", item["Supplier"]),

      ],
    ),
  ),

>>>>>>> 61a61e7c9dc0e8ae2e41810a1c31a52add0d7841
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
                  fontSize: 30,
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
          detailRow("Price", "\$${item["Price"]}"),
          detailRow(
            "Low Stock Threshold",
            item["Minimum Stock"].toString(),
          ),
          detailRow("Supplier", item["Supplier"]),

      
        Row(
          children: [
            Expanded(
        child: SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {Navigator.pushNamed(
          context,
          '/editscreen',
          arguments: item,
        );},
            icon: const Icon(Icons.edit),
            label: const Text("Edit"),
          ),
        ),
      ),
            const SizedBox(width: 30),






            Expanded(child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
          onPressed: () async {
            bool? confirm = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Delete item?"),
                  content: Text(
                "Are you sure you want to delete ${item["Item Name"]}?",
                ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                );
              },
            );
            if (confirm == true) {
              await item.reference.delete();
              Navigator.pop(context);
            }
          },
        ),
        )],
          ),
        ],
      ),
    ),
      );
    }
  }
          













        
      