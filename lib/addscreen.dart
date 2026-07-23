// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController minimumStockController = TextEditingController();
    TextEditingController barcodeController = TextEditingController();
    TextEditingController supplierController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: itemNameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: minimumStockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Minimum Stock",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: barcodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Barcode",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: supplierController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Supplier",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () async {
                try {
                  // 1 - Fixed: collection name now matches Firestore
                  //     exactly ("Items" with capital I).
                  await FirebaseFirestore.instance.collection('Items').add({
                    'Item Name': itemNameController.text,
                    'Category': categoryController.text,
                    'Quantity': int.parse(quantityController.text),
                    'Price': double.parse(priceController.text),
                    // 2 - Fixed: field name now matches Firestore exactly
                    //     ("Minimum Stock" with a space).
                    'Minimum Stock':
                        int.parse(minimumStockController.text),
                        'Barcode': barcodeController,
                        'Supplier':supplierController
                  });

                  // Log this action to the ActivityLog collection so
                  //     it shows up on the Activity Log screen. We store
                  //     the current logged-in user's UID (not a name),
                  //     since that's what links back to the "users"
                  //     collection to look up their role later.
                  await FirebaseFirestore.instance
                      .collection('ActivityLog')
                      .add({
                    'UserId': FirebaseAuth.instance.currentUser?.uid ?? '',
                    'Action': 'Added ${itemNameController.text}',
                    'Timestamp': FieldValue.serverTimestamp(),
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Item added successfully!"),
                    ),
                  );

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: $e"),
                    ),
                  );
                }
              },
              child: const Text("Save Item"),
            ),
          ],
        ),
      ),
    );
  }
}