import 'package:flutter/material.dart';
import 'package:u_eats/components/item.dart';

class CartItem{
  Item item;
  int quantity = 1;

  CartItem({required this.item});
}

class CartItemCard extends StatelessWidget {
  CartItem cartItem;

  CartItemCard({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
        margin: const EdgeInsets.fromLTRB(30, 5, 30, 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cartItem.item.name, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 20
              ),
              ),
              Text(cartItem.quantity.toString(), style: const TextStyle(
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
