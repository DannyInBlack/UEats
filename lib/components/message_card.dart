import 'package:flutter/material.dart';
import 'message.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final Function() delete;

  MessageCard({required this.message
    ,required this.delete
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(child: Image.asset(message.imageUrl)),
        Expanded(
          child: Card(
            margin: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(message.content),
                  ),
                  IconButton(onPressed: delete, icon: Icon(Icons.delete))
                ]),
          ),
        )
      ],
    );
  }
}
