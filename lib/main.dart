import 'package:flutter/material.dart';
import 'package:project/homescreen.dart';     
import 'package:project/stockscreen.dart';
import 'package:project/itemdetailscreen.dart';
import 'package:project/editscreen.dart';
import 'package:project/adminscreen.dart';
import 'package:project/alertscreen.dart';
import 'package:project/logscreen.dart';
import 'package:project/profilescreen.dart';
import 'package:project/ProfileScreen/aboutapp.dart';
import 'package:project/ProfileScreen/accountinfo.dart';
import 'package:project/ProfileScreen/changepassword.dart';
import 'package:project/LoginScreen/loginscreen.dart';
void main() {
  runApp( MaterialApp(
    home: const HomeScreen(),
    routes: {
'/homepage': (context) => const HomeScreen(),
'/stockpage':(context) => const StockScreen(),
'/itemdetails':(context) => const ItemDetailScreen(),
'/editscreen':(context) => const EditScreen(),
'/adminpage':(context) => const AdminScreen(),
'/alertpage':(context) => const AlertScreen(),
'/logpage':(context) => const LogScreen(),
'/profilepage':(context) => const ProfileScreen(),
'/aboutapp':(context) => const AboutApp(),
'/accountinfo':(context) => const AccountInfo(),
'/changepassword':(context) => const ChangePassword(),
}
    
  ));
}

