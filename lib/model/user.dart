import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photourl;
  final List following;
  final List follower;
  final String bio;
  final String username;

  UserModel(
      {required this.email,
      required this.uid,
      required this.photourl,
      required this.following,
      required this.follower,
      required this.bio,
      required this.username});

  Map<String, dynamic> tomap() {
    return {
      'username': username,
      'email': email,
      'bio': bio,
      'uid': uid,
      'following': [],
      'follower': [],
      'photourl': photourl,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot['username'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      uid: snapshot['uid'],
      following: snapshot['following'],
      follower: snapshot['follower'],
      photourl: snapshot['photourl'],
    );
  }
}
