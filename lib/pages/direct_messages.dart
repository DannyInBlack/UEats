import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:u_eats/components/message.dart';
import 'package:u_eats/components/message_card.dart';
import 'package:http/http.dart';

class DirectMessages extends StatefulWidget {
  @override
  State<DirectMessages> createState() => _DirectMessagesState();
}

class _DirectMessagesState extends State<DirectMessages> {

  static List messages = [];

  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/data/not.json');
    // final data = await JSONMessageCodec().decodeMessage(response)
    final data = await JsonDecoder().convert(response)['messages'].map((message) => Message(
        content: message['content'],
        imageUrl: message['image'] )
    ).toList();
    setState(() {
      messages = data;
    });
    print(messages);
    // for(int i = 0 ; i < messages.length; i++){
    //   print(messages[i].content);
    // }
  }


  @override
  void initState() {
    // TODO: implement readJson
    super.initState();
    // readJson();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("uEats"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children:  messages.map((message) => MessageCard(message: message, delete: () {
            setState(() {
              messages.remove(message);
            });
          })).toList(),
        ),
      ),
    );
  }
}




