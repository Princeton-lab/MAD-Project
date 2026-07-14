import 'package:flutter/material.dart';

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
    child:Column(
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
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "142",
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
        color: Colors.purple[100],
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
     ],
    ),
      )
    );
  }
  }
   