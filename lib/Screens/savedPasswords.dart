import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_generator/Constants/rotateTextStyle.dart';
import 'package:password_generator/Screens/manualAdd_modalSheet.dart';
import 'package:password_generator/shared/loading_pulse.dart';

class SavedPasswords extends StatefulWidget {
  final void Function() pageButtonPress;

  SavedPasswords(this.pageButtonPress);

  @override
  _SavedPasswordsState createState() => _SavedPasswordsState();
}

class _SavedPasswordsState extends State<SavedPasswords> {

  final Stream<QuerySnapshot> _passwordsStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('savedPasswords')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbe1e4),
      body: Column(children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.backward,
                  ),
                  onPressed: () {
                    widget.pageButtonPress();
                  }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 5),
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.plusCircle),
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.0)),
                      ),
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (BuildContext context) {
                        return ManualPasswordAdd();
                      });
                },
              ),
            )
          ],
        ),
         Padding(
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
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: _passwordsStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                final TextEditingController _controller = TextEditingController();
                _controller.text = data['Password'];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: ZoomIn(
                    child: new Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: 200,
                                      child: Text(
                                        data['Website'], style: rotateTextStylePink,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                child: IconButton(
                                    icon: FaIcon(FontAwesomeIcons.trashAlt,color: Colors.red,),
                                    onPressed: () async {
                                      FirebaseFirestore.instance.collection('users').
                                      doc(FirebaseAuth.instance.currentUser.uid).
                                      collection('savedPasswords').doc(document.id).delete();
                                    }
                                    ),
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
                              )),
                          Align(alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 2, 0, 10),
                                child: Text(data['DateTime'],style: smallTextItalic,),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        )),
      ]),
    );
  }
}
