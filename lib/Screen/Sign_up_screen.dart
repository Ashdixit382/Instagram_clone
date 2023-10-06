import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/Screen/login_Screen.dart';
import 'package:instagram_flutter/Widgets/Text_field_input.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethod().signUpUser(
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _image!,
    );

    if (res != 'success') {
      showSnackBar(res, context);
      setState(() {
        _isloading = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobilescreenlayout: MobileScreenLayout(),
            webscreenlayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigatortologin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/userimage.jpg'),
                        ),
                  Positioned(
                    bottom: -12,
                    left: 40,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              // text field for username
              TextFieldInput(
                texteditingcontroller: _usernameController,
                hintText: "Username",
                textinputtype: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field for email
              TextFieldInput(
                texteditingcontroller: _emailController,
                hintText: "email address",
                textinputtype: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              // text field for password
              TextFieldInput(
                texteditingcontroller: _passwordController,
                hintText: "Password",
                textinputtype: TextInputType.text,
                ispass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                texteditingcontroller: _bioController,
                hintText: "Bio",
                textinputtype: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // button for login
              InkWell(
                onTap: signupUser,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: blueColor,
                  ),
                  child: _isloading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text('Sign Up'),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account?"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: navigatortologin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Log In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
              // transition
            ],
          ),
        ),
      ),
    );
  }
}
