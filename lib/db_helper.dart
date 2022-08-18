import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DBHelper{
  Box? box;

  DBHelper(){
    openBox();
  }

  openBox(){
    box = Hive.box("money");
  }

  // TODO Add Data in the Hive Database
  Future addData(int amount, DateTime date, String note, String type) async{
    var value = {
      'amount': amount,
      'date': date,
      'type': type,
      'note': note
    };
    box?.add(value);
  }

  // TODO Fetch Data from Hive Database
  Future<Map> fetch() {
    if(box!.values.isEmpty){
      return Future.value({});
    }else{
      return Future.value(box?.toMap());
    }
  }


}