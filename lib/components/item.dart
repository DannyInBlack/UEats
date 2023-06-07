import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Item{
  String name;
  double price;

  Item({required this.name, required this.price});
  factory Item.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Item(
      name: json.data()['name'],
      price: json.data()['price'].toDouble()
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item item;
  final Function() fun;

  const ItemCard({Key? key, required this.item, required this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: fun,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 20
                ),
              ),
              Text(item.price.toString(), style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 20
              ),
              ),
            ],
          ),
        )
    );
  }
}
