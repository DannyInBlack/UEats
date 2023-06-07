import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Restaurant{
  String name;
  String image1;
  String image2;

  Restaurant({required this.name, required this.image1, required this.image2});
  factory Restaurant.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Restaurant(
      name: json.id,
      image1: json.data()['image1'],
      image2: json.data()['image2'],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final args;

  const RestaurantCard({Key? key, required this.restaurant, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: ()=> Navigator.pushNamed(context, '/restaurant_home', arguments: {
          'restaurant': restaurant,
          'user': args,
        }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(restaurant.name, style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 20
            ),),
            if(restaurant.name == "Carletto Coffee" ) Image.asset(restaurant.image1, width: 90, color: Colors.red,)
            else Image.asset(restaurant.image1, width: 90, ),
          ],
        ),
      )
    );
  }
}