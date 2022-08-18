import 'package:expense_manger_app/add_transaction_screen.dart';
import 'package:expense_manger_app/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO Creating an instance of DBHelper Class
  final DBHelper _dbHelper = DBHelper();

  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  getTotalBalance(Map entireData){
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if(value['type'] == "Income"){
        totalBalance += (value['amount'] as  int);
        totalIncome += (value['amount'] as int);
      }else{
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2e7ef),
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        toolbarHeight: 0.0,
      ),
      body: FutureBuilder<Map>(
          future: _dbHelper.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Unexpected Error...!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No Data Found...!"));
              }
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.green[300],
                              backgroundImage: const AssetImage("assets/images/own.jpg",),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Shakeeb Khan",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[500]),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white70,
                          ),
                          child: const Icon(
                            CupertinoIcons.settings_solid,
                            size: 32.0,
                            color: Color(0xff3E454C),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.green.shade300,
                              ]
                          )
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Total Balance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Rs" + totalBalance.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12.0,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(totalIncome.toString()),
                                cardExpense(totalExpense.toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
              // return ListView(
              //   children: [
              //     Row(
              //       children: [
              //         Row(),
              //         const Icon(CupertinoIcons.settings_solid, color: Colors.green,)
              //       ],
              //     )
              //   ],
              // );
            } else {
              return const Center(
                child: Text("Unexpected Error...!"),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        splashColor: Colors.white38,
        focusColor: Colors.black87,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTransactionScreen()
              )
          ).whenComplete(() {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black87,
          size: 32.0,
        ),
      ),
    );
  }

  // TODO Card Income
  Widget cardIncome(String value){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Icon(CupertinoIcons.arrow_down_circle, color: Colors.green,),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Income",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }

  // TODO Card Expense
  Widget cardExpense(String value){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Icon(CupertinoIcons.arrow_up_circle, color: Colors.red,),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Expense",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}
