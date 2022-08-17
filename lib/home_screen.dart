import 'package:expense_manger_app/add_transaction_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        toolbarHeight: 0.0,
      ),
      body: const Center(
        child: Text("No Data...!",  style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        splashColor: Colors.white38,
        focusColor: Colors.black87,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransactionScreen()));
        },
        child: const Icon(Icons.add, color: Colors.black87, size: 32.0,),
      ),
    );
  }
}
