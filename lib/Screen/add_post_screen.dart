import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/model/user.dart';
import 'package:instagram_flutter/provider/user_provider.dart';
import 'package:instagram_flutter/resources/firestore_method.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  String imagename =
      'https://www.shutterstock.com/image-vector/dotted-spiral-vortex-royaltyfree-images-600w-2227567913.jpg';
  bool _isLoading = false;

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Add your Post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text('Take a photo'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.camera);
                setState(
                  () {
                    _file = file;
                  },
                );
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text('Choose a photo'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(
                  () {
                    _file = file;
                  },
                );
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String Profimage) async {
    try {
      setState(() {
        _isLoading = true;
      });
      String res = await FireStoreMethod().uploadPost(
          _descriptionController.text, _file!, uid, username, Profimage);

      if (res == "success") {
        _isLoading = false;
        showSnackBar('posted!', context);
        cleanImage();
      } else {
        _isLoading = false;
        showSnackBar(res, context);
        cleanImage();
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(err.toString(), context);
    }
  }

  void cleanImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload,
              ),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: cleanImage,
              ),
              title: const Text('Post'),
              actions: [
                TextButton(
                  onPressed: () =>
                      postImage(user.uid, user.username, user.photourl),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(imagename),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Write a caption...",
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                              image: MemoryImage(_file!),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
