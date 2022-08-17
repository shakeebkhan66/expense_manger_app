import 'dart:core';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {

  int? amount;
  var note = "Some Expense";
  var type = "Income";
  DateTime selectedData = DateTime.now();

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "May",
    "Jun",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  // TODO For Selecting Date Function
  Future<void> _selectDate(BuildContext context) async{
    final DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: selectedData,
        firstDate: DateTime(2022, 01),
        lastDate: DateTime(2025, 01)
    );
    if(_picked != null && _picked != selectedData){
      setState(() {
        selectedData = _picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 110.0,),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
                child: Text(
              "Add Transaction",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  letterSpacing: 1.3,
                  wordSpacing: 1.0,
                  shadows: [
                    Shadow(
                      color: Colors.greenAccent,
                      offset: Offset(0.3, 0.0),
                      blurRadius: 5,
                    )
                  ]),
            )),
          ),
          const SizedBox(
            height: 55,
          ),
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Icon(
                    Icons.attach_money,
                    size: 26.0,
                    color: Colors.black87,
                  )),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: TextFormField(
                  onChanged: (val){
                    try{
                      amount = int.parse(val);
                    }catch(e){}
                  },
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "0",
                    hintStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Icon(
                    Icons.note_alt,
                    size: 26.0,
                    color: Colors.black87,
                  )),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: TextFormField(
                  onChanged: (val){
                    note = val;
                  },
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    hintText: "Note on Transaction",
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Icon(
                    Icons.moving_rounded,
                    size: 26.0,
                    color: Colors.black87,
                  )),
              const SizedBox(
                width: 30,
              ),
              ChoiceChip(
                label: const Text("Income"),
                selected: type == "Income" ? true : false,
                selectedColor: Colors.green[300],
                onSelected: (val){
                  if(val){
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
              const SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: const Text(
                  "Expense",
                  style: TextStyle(color: Colors.black),
                ),
                selected: type == "Expense" ? true : false,
                selectedColor: Colors.green[300],
                onSelected: (val){
                  if(val){
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              )
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  _selectDate(context);
                },
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Icon(
                      Icons.date_range_outlined,
                      size: 26.0,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(
                width: 30,
              ),
              Text("${selectedData.day} ${months[selectedData.month - 1]}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),)
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              splashColor: Colors.white70,
              focusColor: Colors.white70,
              color: Colors.green[300],
              child: const Text(
                "Add",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
