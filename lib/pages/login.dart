import 'package:flutter/material.dart';
import 'package:u_eats/components/login_input.dart';
import 'package:u_eats/components/title.dart' as head;
import 'package:u_eats/services/auth.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    head.Title(),
                    head.AAST(),
                    LoginInput(),
                  ]
                )
              )
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 350),
              child: Column(
                children: [

                  FilledButton(
                    style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll(Size(300,50)),
                        backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                    child: const Text(
                      'Sign up instead',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
