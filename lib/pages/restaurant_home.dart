import 'package:u_eats/components/db.dart';
import 'package:flutter/material.dart';
import 'package:u_eats/components/restaurant.dart';
import 'package:u_eats/components/item.dart';
import 'package:u_eats/components/cart_item.dart';


Future<List<Item>> fetchItems(String name) async {
  final resList = await DB.getConn().collection('items').where("restaurant", isEqualTo: name).get();

  return resList.docs.map((element) => Item.fromJson(element)).toList();
}


class RestaurantHome extends StatefulWidget {
  const RestaurantHome({Key? key}) : super(key: key);

  @override
  State<RestaurantHome> createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {

  late Future<List<Item>> items;
  List<CartItem> cart = [];

  void addToCart(Item item){
    final itemToBeAdded = CartItem(item: item);
    setState(() {
      CartItem foundCar = cart.firstWhere((element) => element.item.name == item.name, orElse: () => itemToBeAdded);
      if(foundCar == itemToBeAdded){
        cart.add(itemToBeAdded);
      }
      else {foundCar.quantity++;}

    });
    print(cart);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final restaurant = args['restaurant'];
    final user = args['user'];

    setState(() {
      items = fetchItems(restaurant.name);
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(restaurant.image2),
            Container(
              decoration: const BoxDecoration(
                gradient:  LinearGradient(colors: [
                  Colors.cyanAccent,
                  Colors.white,
                  Colors.cyanAccent
                ]),
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.blue, width: 5)
                )
              ),
              child: Center(
                child: Text(restaurant.name, style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Home',
                ))
              ),
            ),
            FutureBuilder(
                future: items,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: snapshot.data!.map((e) => ItemCard(item: e, fun: () => addToCart(e))).toList(),
                    );
                  }
                  else if(snapshot.hasError){
                    print(snapshot.error);
                  }
                  return const CircularProgressIndicator();
                }
            ),
            const  Padding(
              padding:  EdgeInsets.fromLTRB(0, 20, 0, 0),
              child:  Center(
                child:  Text("Cart: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cart.map((e) => CartItemCard(cartItem: e)).toList(),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  FilledButton(
                    style: ButtonStyle(
                        fixedSize: const MaterialStatePropertyAll(Size(200,10)),
                        // maximumSize: const MaterialStatePropertyAll(Size(100,50)),
                        backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
                    ),
                    onPressed: () {
                      setState(() {
                        cart.clear();
                      });
                    },
                    child: const Text("Clear",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  FilledButton(
                    style: ButtonStyle(
                        fixedSize: const MaterialStatePropertyAll(Size(200,10)),
                        // maximumSize: const MaterialStatePropertyAll(Size(100,50)),
                        backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
                    ),
                    onPressed: () {
                      if(cart.isEmpty){
                        showError("Empty cart, try putting in something first", context);
                        return;
                      }
                      // Map<String, dynamic> order = {
                      //   'items' = [],
                      //
                      // }

                      List<String> items= [];

                      double price = 0;
                      for(int i = 0; i < cart.length; i++){
                        items.add("${cart[i].item.name} ${cart[i].quantity}");
                        price += cart[i].item.price * cart[i].quantity;
                      }
                      String r_name = restaurant.name;
                      String uid = user.uid;

                      if(user.balance < price){
                        showError("Not enough balance", context);
                        return;
                      }
                      final db = DB.getConn();

                      db.collection("orders").add({
                        "items" : items,
                        "price" : price,
                        "r_name" : r_name,
                        "userid" : uid
                      });
                      db.collection("users").doc(uid).update({
                        "balance" : (user.balance - price)
                      });
                      user.balance -= price;
                      showError("Ordered successfully! Price = $price", context);
                      Future.delayed(const Duration(seconds: 2), () => {
                          Navigator.popUntil(context, (route) => route.settings.name == "/home"),
                          Navigator.popAndPushNamed(context, "/home", arguments: user)
                      });


                      // print('$price $r_name $uid $items');
                  },
                    child: const Text("Make Order",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

          ],
        )
      ),
    );
  }
}
