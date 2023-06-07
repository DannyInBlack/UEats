import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:u_eats/components/register_input.dart';
import 'package:u_eats/components/title.dart' as head;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


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
                          children:  [
                            const head.AAST(),
                            RegisterInput(),
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
                          backgroundColor: MaterialStatePropertyAll(Colors.yellow[100])
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: const Text(
                        'Log in instead',
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
  //
}
