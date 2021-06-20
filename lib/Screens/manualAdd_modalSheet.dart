import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_generator/Constants/rotateTextStyle.dart';
import 'package:password_generator/Screens/homepage.dart';
import 'package:password_generator/Screens/savedPasswords.dart';
import 'package:password_generator/saving&deleting/save_note.dart';
import 'package:provider/provider.dart';

class ManualPasswordAdd extends StatefulWidget {
  const ManualPasswordAdd({Key key}) : super(key: key);

  @override
  _ManualPasswordAddState createState() => _ManualPasswordAddState();
}

class _ManualPasswordAddState extends State<ManualPasswordAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWebsite = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Save _save = Save();
  Future<QuerySnapshot> passwordList;

  Future<QuerySnapshot> getPasswordList() async{
    CollectionReference passwords = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('savedPasswords');
    passwordList = passwords.get();
    return passwordList;
  }

  @override
  Widget build(BuildContext context) {
    DateTime _dateTime = DateTime.now();
    String dateTime = _dateTime.toString().substring(0, 10);
    return Container(
      height: 320,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(
                  text: "Save your already created \n",
                  style: smallText,
                  children: <TextSpan>[
                    TextSpan(
                      text: "Password",
                      style: TextStyle(color: Colors.pink, fontSize: 22),
                    ),
                  ])),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerWebsite,
                    decoration: InputDecoration(
                      hintText: "  Website/Application Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.pink)),
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                    value.isEmpty ? 'This cannot be left blank' : null,
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _controllerPassword,
                    decoration: InputDecoration(
                      hintText: "  Enter Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.pink)),
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                    value.isEmpty ? 'This cannot be left blank' : null,
                  ),
                ],
              ),
            ),
          ),
          // ignore: deprecated_member_use
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.deepPurple),
            child: FlatButton(
              onPressed: () async {
                print(_controllerWebsite.text);
                if (_formKey.currentState.validate()) {
                  print('Form is valid');
                  var data = {'Website': _controllerWebsite.text, 'Password': _controllerPassword.text, 'DateTime': dateTime};
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('savedPasswords').add(data).then((value){
                        setState(() {

                        });
                        Navigator.pop(context);
                  });
                } else {
                  print('Form is invalid');
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
