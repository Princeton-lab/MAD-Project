import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:SafeArea(
  child:Padding(
    padding:const EdgeInsets.all(20),
    child:ListView(

      children:[
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children:[
          const Text('DASHBOARD',
          style:TextStyle(
            fontSize:24,
            fontWeight:FontWeight.bold
            ),
          ),
          IconButton(
            onPressed:(){},
            icon :const Icon(Icons.notifications_none),
          ),
   
          
        ],
        ),
               const SizedBox(height:15 ),
          const Align(alignment: Alignment.centerLeft,
          child: Text('Hello John!',//will be changed to the name of the user logged in
          style:TextStyle(
            fontSize:20,
            fontWeight:FontWeight.bold
            ),
          ),
          ),
        const SizedBox(height:5),
        const Align(alignment: Alignment.centerLeft,
          child: Text('Here`s your inventory overview',
          style:TextStyle(
           
            color:Colors.grey
            ),
          ),
          ),
    
      
       
  Container(
  padding: const EdgeInsets.all(20),
  width: double.infinity,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.circular(12),
  ),

  child: Row(
    
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     

      // LEFT SIDE
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Total Items",
            style: TextStyle(
              color: Colors.black,
            ),
          ),

          SizedBox(height: 8),

          StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
          .collection('Items')
          .snapshots(),
  builder: (context, snapshot) {

    if (!snapshot.hasData) {
      return const Text("0");
    }

    final items = snapshot.data!.docs;

    return Text(
      items.length.toString(),
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  },
),

        ],
      ),

      // RIGHT SIDE
      Container(padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        
      ),
     child:IconButton(
          color: Colors.purple,
          tooltip: 'Open stock screen',
          icon: const Icon(Icons.inventory_2),
       onPressed: () {
        Navigator.pushNamed(context, '/stockpage');
       },
      ),
  )],
  ),
),
const SizedBox(height: 20),
  
       
  Container(
  padding: const EdgeInsets.all(20),
  width: double.infinity,
  decoration: BoxDecoration(
  border: Border.all(color: Colors.black),
    
    borderRadius: BorderRadius.circular(12),
  ),

  child: Row(
    
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     

      // LEFT SIDE
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Low Stock Items",
            style: TextStyle(
              color: Colors.black,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "TBA",//to be added
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),

      // RIGHT SIDE
      Container(padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        
      ),
     child:IconButton(
          color: Colors.red,
          tooltip: 'Open low item screen',
          icon: const Icon(Icons.warning_amber_rounded),
       onPressed: () {
        Navigator.pushNamed(context, '/alertpage');
       },
      ),
  )],
  ),
),
SizedBox(height: 20),

 Container(
  padding: const EdgeInsets.all(20),
  width: double.infinity,
  decoration: BoxDecoration(
  border: Border.all(color: Colors.black),
    
    borderRadius: BorderRadius.circular(12),
  ),

  child: Row(
    
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     

      // LEFT SIDE
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Total Stock Value",
            style: TextStyle(
              color: Colors.black,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "TBA",//to be added
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),

      // RIGHT SIDE
      Container(padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        
      ),
     child:IconButton(
          color: Colors.green,
          tooltip: 'Open total stock value screen',
          icon: const Icon(Icons.attach_money),
       onPressed: () {
        Navigator.pushNamed(context, '/stockpage');
       },
      ),
  )],
  ),
),
SizedBox(height: 20),

 Container(
  padding: const EdgeInsets.all(20),
  width: double.infinity,
  decoration: BoxDecoration(
  border: Border.all(color: Colors.black),
    
    borderRadius: BorderRadius.circular(12),
  ),

  child: Row(
    
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     

      // LEFT SIDE
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Recent activities",
            style: TextStyle(
              color: Colors.black,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "TBA",//to be added
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),

      // RIGHT SIDE
      Container(padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        
      ),
     child:IconButton(
          color: Colors.blue,
          tooltip: 'Open recent activities',
          icon: const Icon(Icons.calendar_month),
       onPressed: () {
        Navigator.pushNamed(context, '/logpage');
       },
      ),
  )],
  ),
)

      ],
    ),
  
  ),
),

    bottomNavigationBar: Container(
    padding: const EdgeInsets.all(15),
    color: const Color.fromARGB(255, 185, 176, 202),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: [
      IconButton(
          color: Colors.red,
          tooltip: 'Open home screen',
          icon: const Icon(Icons.home),
       onPressed: () {
        Navigator.pushNamed(context, '/homepage');
       },
      ),
       SizedBox(height: 20),
       IconButton(
          color: Colors.white,
          tooltip: 'Open stock screen',
          icon: const Icon(Icons.list_alt),
       onPressed: () {
        Navigator.pushNamed(context, '/stockpage');
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
     ],
    ),
      )
    );
  }
  }
   
   