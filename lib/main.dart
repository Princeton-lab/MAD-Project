import 'package:flutter/material.dart';
import 'package:project/homescreen.dart';     
import 'package:project/stockscreen.dart';
import 'package:project/itemdetailscreen.dart';
import 'package:project/add/editscreen.dart';
import 'package:project/add/adminscreen.dart';
import 'package:project/add/alertscreen.dart';
import 'package:project/add/logscreen.dart';
import 'package:project/add/profilescreen.dart';

void main() {
  runApp( MaterialApp(
    home: HomeScreen(),
    routes: {
'/homepage': (context) => const HomeScreen(),
'/stockpage':(context) => const StockScreen(),
'/itemdetails':(context) => const ItemDetailScreen(),
'/editscreen':(context) => const EditScreen(),
'/adminpage':(context) => const AdminScreen(),
'/alertpage':(context) => const AlertScreen(),
'/logpage':(context) => const LogScreen(),
'/profilepage':(context) => const ProfileScreen(),
}
    
  ));
}

