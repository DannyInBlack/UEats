import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('UEats', style: TextStyle(
      fontSize: 70,
      color: Colors.white,
      fontFamily: 'Home',
    ));
  }
}

class AAST extends StatelessWidget {
  const AAST({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/AAST.png', width: 70);
  }
}
