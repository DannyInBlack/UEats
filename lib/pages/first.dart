import 'package:flutter/material.dart';
import 'package:u_eats/components/title.dart' as head;

class First extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const head.Title(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 200, 0 ,20),
                    child: FilledButton(
                      style:  ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll(Size(300,50)),
                        backgroundColor: MaterialStatePropertyAll(Colors.yellow[200]),
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 20, color: Colors.black)
                      )
                    ),
                  ),
                  FilledButton(
                    style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll(Size(300,50)),
                        backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                    child: const Text(
                        'Create a new account',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: head.AAST(),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
      backgroundColor: Colors.black,
    );
  }
}
