import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DB{
  static dynamic app;
  static dynamic balance;
  static dynamic user;

  static FirebaseFirestore getConn(){
    app ??= FirebaseFirestore.instance;
    return app;
  }

}
void showError (msg, context){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(msg, style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        );
      }
  );
}