import 'package:flutter/material.dart';
import 'db.dart';
import 'user.dart';

class RegisterInput extends StatelessWidget {

  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  RegisterInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 60, 0, 30),
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
          TextFormField(
            controller: email,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              prefixIconColor: Colors.white,
              prefixStyle: TextStyle(color: Colors.white),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          TextFormField(
            controller: name,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.paste),
              prefixIconColor: Colors.white,
              prefixStyle: TextStyle(color: Colors.white),
              labelText: 'Full Name',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          TextFormField(
            controller: phoneNo,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone),
              prefixIconColor: Colors.white,
              prefixStyle: TextStyle(color: Colors.white),
              labelText: 'Telephone No.',
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
                  backgroundColor: MaterialStatePropertyAll(Colors.yellow[200])
              ),
              onPressed: () {
                var db = DB.getConn();

                String idText = id.text.trim();
                String emailText = email.text.trim();
                String passwordText = password.text;
                String phoneNoText = phoneNo.text.trim();
                String nameText = name.text.trim();

                if(idText.isEmpty ||
                    emailText.isEmpty ||
                    passwordText.isEmpty ||
                    phoneNoText.isEmpty ||
                    nameText.isEmpty){
                  showError("Please fill in data", context);
                  return;
                }

                final user = <String, dynamic>{
                  "email": emailText,
                  "name": nameText,
                  "password": passwordText,
                  "tel": phoneNoText,
                  "balance": 0.0
                };
                final docUser = db.collection("users").doc(idText);

                try {
                  docUser.get().then((docSnapshot) => {
                    if (docSnapshot.exists){
                      showError("ID is already registered, try a different one", context)
                    }
                    else {
                      docUser.set(user),

                      Navigator.popAndPushNamed(
                          context,
                          '/home',
                          arguments: User(uid: idText)
                      )
                    } // create the document
                  });
                }
                catch (e){
                  showError("Cannot connect to database, please try again later", context);
                }
              } ,
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
