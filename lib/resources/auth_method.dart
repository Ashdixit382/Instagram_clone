import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // storage the files
        String photourl =
            await StorageMethod().uploadImageToStorage('photopic', file, false);
        // add user to our database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'email': email,
          'bio': bio,
          'uid': cred.user!.uid,
          'following': [],
          'follower': [],
          'photourl': photourl,
        });
        print(cred.user!.uid);
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'email': email,
        //   'password': password,
        //   'bio': bio,
        //   'uid': cred.user!.uid,
        //   'following': [],
        //   'follower': [],
        // });

        res = "success";
      }
    }
    // on FirebaseAuthException catch(err){
    //   if(err.code == )
    // }

    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> LoginUser(
      {required String email, required String password}) async {
    String res = "Some error Occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // login user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please Enter all the field ";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
