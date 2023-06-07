import 'package:flutter/material.dart';
import 'package:u_eats/components/title.dart' as head;
import 'package:u_eats/components/restaurant.dart';
import 'package:u_eats/components/user.dart';
import 'package:u_eats/components/db.dart';
import 'package:u_eats/components/cart_item.dart';

Future<List<Restaurant>> fetchRestaurants() async {
  final resList = await DB.getConn().collection('restaurants').get();

  return resList.docs.map((element) => Restaurant.fromJson(element)).toList();
}


class Restaurants extends StatefulWidget {

  const Restaurants({Key? key}) : super(key: key);

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {

  late Future<List<Restaurant>> restaurants;


  @override
  void initState() {
    super.initState();
    restaurants = fetchRestaurants();
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const head.AAST(),
            const Padding(
                padding:  EdgeInsets.fromLTRB(0, 20, 0, 20),
                child:  Text(
                    'Restaurants Available',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25
                    )
                )
            ),
            FutureBuilder(
                future: restaurants,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    print(snapshot.data);
                    return Column(
                      children: snapshot.data!.map((e) => RestaurantCard(restaurant: e, args: args)).toList(),
                    );
                  }
                  else if(snapshot.hasError){
                    print(snapshot.error);
                  }
                  return const CircularProgressIndicator();
                }
            ),
            Text('Balance = ${args.balance} EGP', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}


