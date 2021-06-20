import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_generator/Constants/rotateTextStyle.dart';
import 'package:password_generator/shared/loading_pulse.dart';

class SavedPasswords extends StatefulWidget {
  const SavedPasswords({Key key}) : super(key: key);

  @override
  _SavedPasswordsState createState() => _SavedPasswordsState();
}

class _SavedPasswordsState extends State<SavedPasswords> {
  Future<QuerySnapshot> passwordList;
  bool isObscure=false;


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

    return Scaffold(
      backgroundColor: Color(0xfffbe1e4),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          FadeInDown(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Align(
                    child: Text(
                      "Saved Passwords:",
                      style: rotateTextStyleHeading2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: getPasswordList(), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        Map passwordData = snapshot.data.docs[index].data();
                        TextEditingController _controller = TextEditingController();
                        _controller.text = passwordData['Password'];
                        return ZoomIn(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
                              child: Container(
                                height: 150,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  passwordData['Website'], style: rotateTextStylePink,
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                            child: IconButton(icon: FaIcon(FontAwesomeIcons.trashAlt,color: Colors.red,),
                                                onPressed: () async
                                                {
                                                  //List Delete and Update
                                                  await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                     myTransaction.delete(snapshot.data.docs[index].reference);
                                                  }).then((value) {
                                                    setState(() {
                                                      
                                                    });
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                      Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
                                            child: TextField(
                                              controller: _controller,
                                              readOnly: true,
                                              enableInteractiveSelection: false,
                                              decoration: new InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.copy,
                                                  ),
                                                  onPressed: () {
                                                    final data = ClipboardData(
                                                        text: _controller.text);
                                                    Clipboard.setData(data);
                                                    final snackBar = SnackBar(
                                                      content: Text(
                                                        "Password Copied to Clipboard",
                                                        style: rotateTextStyle,
                                                      ),
                                                      backgroundColor:
                                                      Color(0xffe79aad),
                                                    );
                                                    Scaffold.of(context)
                                                      ..removeCurrentSnackBar()
                                                      ..showSnackBar(snackBar);
                                                    },
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(50)),
                                                    borderSide:
                                                    BorderSide(color: Colors.pink)),
                                                fillColor: Colors.white,
                                                filled: true,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      });
                } else if (snapshot.connectionState == ConnectionState.waiting)
                  return Loading();
                else
                  return Text("Cant Load");
                },
            ),
          ),
        ],
      ),
    );
  }
}
