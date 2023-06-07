import 'package:flutter/material.dart';
import 'db.dart';
import 'user.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({Key? key}) : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    TextEditingController id = TextEditingController(), password = TextEditingController();

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 140, 0, 30),
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20),),
        border: Border.all(
          width: 2,
          color: Colors.blueGrey,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: id,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              prefixIconColor: Colors.white,
              prefixStyle: TextStyle(color: Colors.white),
              labelText: 'ID',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          TextFormField(
            controller: password,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.password),
              prefixIconColor: Colors.white,
              prefixStyle: TextStyle(color: Colors.white),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: FilledButton(
              style: ButtonStyle(
                  minimumSize: const MaterialStatePropertyAll(Size(300,50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.yellow[200]),

              ),
              onPressed: () {
                var db = DB.getConn();

                if(id.text.isEmpty || password.text.isEmpty){
                  showError("Enter id and password!", context);
                  return;
                }

                final docUser = db.collection("users").doc(id.text);
                try {
                  showError("Loading", context);
                  docUser.get().then((value) => {
                    Navigator.of(context, rootNavigator: true).pop(),
                    if(value.exists){
                      if(value.data()!['password'] == password.text){
                        Navigator.popAndPushNamed(
                            context,
                            '/home',
                            arguments: User(uid: id.text, balance: value.data()!['balance'].toDouble())
                        )
                      }
                      else{
                        showError("Incorrect password", context)
                      }
                    }
                    else{
                      showError("Id doesn't exist", context)
                    }
                  });
                } catch(e){
                  showError("Can't connect, please try later", context);
                }
              },
              child: const Text(
                'Log in',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
