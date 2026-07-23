// ignore_for_file: unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool scanned = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: const Text("Scan Barcode"),
      ),

      body: MobileScanner(

        onDetect: (capture) async {
          if (scanned) return;

final barcode = capture.barcodes.first.rawValue;

if (barcode == null) return;

scanned = true;

print(barcode);
        },

      ),
    );
  }
}