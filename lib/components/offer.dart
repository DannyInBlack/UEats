import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Offer {
  String restaurant;
  String item;
  double price;
  Offer({required this.restaurant, required this.item, required this.price});
  factory Offer.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Offer(
      restaurant: json.data()['restaurant'],
      item: json.data()['item'],
      price: json.data()['price'].toDouble(),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(offer.restaurant, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red
              ),),
              Text(offer.item),
              Text('  ${offer.price}', style: const TextStyle(color: Colors.blue),),
            ],
          ),
        )
    );
  }
}