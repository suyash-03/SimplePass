import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;
  set isSigningIn (bool isSigningIn){
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login(BuildContext context)  async{
    isSigningIn = true;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if(googleSignInAccount == null){
      isSigningIn = false;
    }
    else{
      print(googleSignInAccount);
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult = await auth.signInWithCredential(credential);
      final User user = authResult.user;
      isSigningIn = false;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

      users.doc(user.uid).get().then((doc) => {
        if(doc.exists){
          doc.reference.update(userData)
        }else{
          users.doc(user.uid).set(userData)
        }
      });
    }
  }

  void logout(BuildContext context) async{
    await googleSignIn.disconnect();
    auth.signOut();
  }

}