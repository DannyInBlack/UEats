import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:u_eats/components/db.dart';
import 'package:u_eats/components/title.dart' as head;
import 'package:u_eats/components/offer.dart';
import 'package:u_eats/components/user.dart';

Future<List<Offer>> fetchSpecialOffers() async {
  final offerList = await DB.getConn().collection('specialOffers').get();

  // print(offerList.docs.first.data());

  return offerList.docs.map((element) => Offer.fromJson(element)).toList();
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  late Future<List<Offer>> specialOffers;

  @override
  void initState() {
    super.initState();
    specialOffers = fetchSpecialOffers();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const head.AAST(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll(Size(100,100)),
                        backgroundColor: MaterialStatePropertyAll(Colors.blue[200])
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/restaurants', arguments: args),
                    child: const Text(
                      'Make Order',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll(Size(10,100)),
                        backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
                    ),
                    onPressed: () => {
                      showDialog(
                          context: context, 
                          builder: (context) {
                            TextEditingController amount = TextEditingController();
                            return SimpleDialog(
                              backgroundColor: Colors.black,
                              alignment: Alignment.center,
                              children: [
                                TextFormField(
                                  controller: amount,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    prefixStyle: TextStyle(color: Colors.white),
                                    labelText: 'Amount (in EGP)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: FilledButton(
                                    style: ButtonStyle(
                                      fixedSize: const MaterialStatePropertyAll(Size(100,10)),
                                      // maximumSize: const MaterialStatePropertyAll(Size(100,50)),
                                      backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
                                    ),
                                    onPressed: () {
                                      String amountText = amount.text.trim();
                                      try{
                                        double amountValue = double.parse(amountText);
                                        var db = DB.getConn();
                                        var data = {'balance': amountValue + args.balance};
                                        db.collection('users').doc(args.uid).update(data);
                                        db.collection('users').doc(args.uid).get().then((doc_ref) {
                                          double newBalance = doc_ref.data()!['balance'];
                                          amount.clear();
                                          setState(() {
                                            args.balance = newBalance;
                                          });
                                          Navigator.of(context, rootNavigator: true).pop();
                                        });


                                      } catch (e){
                                        showError("Enter a number!", context);
                                      }
                                    },
                                    child: const Text("Add",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
                                )
                              ],
                            );
                          }
                      )
                    },
                    child: const Text(
                      'Add Balance',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding:  EdgeInsets.fromLTRB(0, 20, 0, 20),
              child:  Text(
                  'Special Offers Today: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                  )
                )
            ),
            FutureBuilder(
              future: specialOffers,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  print(snapshot.data);
                  return Column(
                    children: snapshot.data!.map((e) => OfferCard(offer: e)).toList(),
                  );
                }
                else if(snapshot.hasError){
                  print(snapshot.error);
                }
                return const CircularProgressIndicator();
              }
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: FilledButton(
                style: ButtonStyle(
                    fixedSize: const MaterialStatePropertyAll(Size(100,10)),
                    // maximumSize: const MaterialStatePropertyAll(Size(100,50)),
                    backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
                ),
                onPressed: () {
                 Navigator.popAndPushNamed(context, '/home', arguments: args);
                },
                child: const Text("Refresh",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Text('Balance = ${args.balance} EGP', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}


