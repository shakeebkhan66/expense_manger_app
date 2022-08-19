import 'dart:ui';

import 'package:expense_manger_app/add_transaction_screen.dart';
import 'package:expense_manger_app/db_helper.dart';
import 'package:fl_chart/fl_chart.dart';
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
  DateTime today = DateTime.now();

  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];

  // TODO Plotting Values in Chart Function
  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == "Expense" &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(FlSpot(
          (value['date'] as DateTime).day.toDouble(),
          (value['amount'] as int).toDouble(),
        ));
      }
    });
    return dataSet;
  }

  // TODO For Getting and Calculating Total Balance
  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == "Income") {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
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
              getPlotPoints(snapshot.data!);
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
                              backgroundImage: const AssetImage(
                                "assets/images/own.jpg",
                              ),
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
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.green[300],
                          ),
                          child: const Icon(CupertinoIcons.settings_solid,
                              size: 32.0, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: LinearGradient(colors: [
                            Colors.green,
                            Colors.green.shade300,
                          ])),
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
                          const SizedBox(
                            height: 12.0,
                          ),
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
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Expenses",
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  dataSet.length < 2
                      ? Container(
                          height: 300,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 40.0),
                          margin: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 6.0,
                                    spreadRadius: 5.0,
                                    offset: const Offset(0, 4))
                              ]),
                          child: const Text(
                            "Not Enough Values to Render Chart",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black87),
                          ))
                      : Container(
                          height: 300,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 40.0),
                          margin: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 6.0,
                                    spreadRadius: 5.0,
                                    offset: const Offset(0, 4))
                              ]),
                          child: LineChart(LineChartData(
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: getPlotPoints(snapshot.data!),
                                  isCurved: false,
                                  color: Colors.green[600],
                                  barWidth: 2.5,
                                ),
                              ])),
                        ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Recent Expenses",
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map dataAtIndex = snapshot.data![index];
                      if (dataAtIndex['type'] == "Income") {
                        return incomeTile(
                            dataAtIndex['amount'], dataAtIndex['note']);
                      } else {
                        return expenseTile(
                            dataAtIndex['amount'], dataAtIndex['note']);
                      }
                    },
                  )
                ],
              );
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
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTransactionScreen()))
              .whenComplete(() {
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
  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Icon(
            CupertinoIcons.arrow_down_circle,
            color: Colors.green,
          ),
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
  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Icon(
            CupertinoIcons.arrow_up_circle,
            color: Colors.red,
          ),
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

  // TODO Expense Tile
  Widget expenseTile(int value, String note) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: Colors.green[100], borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_circle_up_outlined,
                    size: 27.0,
                    color: Colors.red[700],
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              Text(
                "- $value",
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w700),
              )
            ],
          )
        ],
      ),
    );
  }

  // TODO Income Tile
  Widget incomeTile(int value, String note) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: Colors.green[100], borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_circle_down_outlined,
                    size: 27.0,
                    color: Colors.green[700],
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    "Income",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              Text(
                "+ $value",
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w700),
              )
            ],
          )
        ],
      ),
    );
  }
}
