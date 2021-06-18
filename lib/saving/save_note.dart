
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Save {
  String website;
  String password;
  String dateTime;
  void saveNote() async{
    CollectionReference passwords = FirebaseFirestore.instance.
                                     collection('users').doc(FirebaseAuth.instance.currentUser.uid).
                                      collection('savedPasswords');
    var data = {
      'Website' : website,
      'Password': password,
      'DateTime': dateTime
    };
    passwords.add(data);
  }
}
