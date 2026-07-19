// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

      const SizedBox(height: 25),

      ElevatedButton(
        onPressed: () async{
           await FirebaseFirestore.instance.collection('items').add({

      'Item Name': itemNameController.text,

      'Category': categoryController.text,

      'Quantity': int.parse(quantityController.text),

      'Price': double.parse(priceController.text),

      'MinimumStock':
          int.parse(minimumStockController.text),

    });

    Navigator.pop(context);
        },
        child: const Text("Save Item"),
      )

    ],
  ),
),
      );
  }
}