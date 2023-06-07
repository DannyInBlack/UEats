import 'package:flutter/material.dart';
import 'package:u_eats/pages/first.dart';
import 'package:u_eats/pages/login.dart';
import 'package:u_eats/pages/register.dart';
import 'package:u_eats/pages/home.dart';
import 'package:u_eats/pages/restaurants.dart';
import 'package:u_eats/pages/restaurant_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;



Future main() async {
    WidgetsFlutterBinding.ensureInitialized();


    app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    auth = FirebaseAuth.instanceFor(app: app);

    runApp(MaterialApp(
        initialRoute: '/first',
        routes: {
          '/first' : (context) =>  First(),
          '/home' : (context) => const Home(),
            '/login' : (context) => const Login(),
            '/register' : (context) => const Register(),
            '/restaurants' : (context) => const Restaurants(),
            '/restaurant_home' : (context) => const RestaurantHome(),
        }
    ));
}


