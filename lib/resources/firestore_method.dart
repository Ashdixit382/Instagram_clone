import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/model/post.dart';
import 'package:instagram_flutter/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String Profimage) async {
    String res = "Some error occurred";

    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          likes: [],
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: Profimage);

      await _firestore.collection('posts').doc(uid).set(post.toJson());
      res = "success";
    } catch (err) {
      res.toString();
    }
    return res;
  }
}
