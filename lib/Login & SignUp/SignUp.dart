import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../Authentication Methods/Methods.dart';
import 'Login.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({Key? key}) : super(key: key);

  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {
  File? image;

  Future pickImage() async {
    // try {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
    // } on PlatformException catch (e) {
    //   print('Failed to pick image: $e');
    // }
  }

  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const SpinKitChasingDots(
                  color: Colors.deepOrange,
                ),
              ),
            )
          : SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 190,
                        width: 170,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.elliptical(400, 400)),
                          gradient: LinearGradient(colors: [
                            Color(0xffffa500),
                            Colors.deepOrangeAccent
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: const [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "S",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ),
                          Text(
                            "I",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          Text(
                            "G",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          Text(
                            "N",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "U",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          Text(
                            "p",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 4,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(500),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: ClipOval(
                            child: Container(
                              height: 120,
                              width: 120,
                              child: const Icon(FontAwesomeIcons.image,
                                  color: Colors.black, size: 40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                                controller: nameEditingController,
                                decoration: InputDecoration(
                                    hintText: "Enter your Name",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.grey.shade300,
                                    filled: true,
                                    prefixIcon: const Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    )),
                                validator: (name) {
                                  const pattern =
                                      r"^(?=.{3,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$";
                                  final regExp = RegExp(pattern);
                                  if (name!.trim().isEmpty) {
                                    return 'Username is Required';
                                  } else if (!regExp.hasMatch(name)) {
                                    return 'Enter a valid Username having at least 3 characters';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: emailEditingController,
                              decoration: InputDecoration(
                                  hintText: "Enter your Email",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.solidEnvelope,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  )),
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid Email'
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: passwordEditingController,
                              decoration: InputDecoration(
                                  hintText: "Enter your Password",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  )),
                              obscureText: true,
                              validator: (value) {
                                if (value != null && value.length < 8) {
                                  return 'Enter minimum 8 characters';
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              onTap: () {
                                final isValidForm =
                                    formkey.currentState!.validate();
                                if (isValidForm) {
                                  if (nameEditingController.text.isNotEmpty &&
                                      emailEditingController.text.isNotEmpty &&
                                      passwordEditingController
                                          .text.isNotEmpty) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    createAccount(
                                            nameEditingController.text,
                                            emailEditingController.text,
                                            passwordEditingController.text)
                                        .then((user) {
                                      if (user != null) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const Loginscreen()));
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    });
                                  } else {}
                                }
                              },
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffffa500),
                                    Colors.deepOrangeAccent,
                                  ]),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 19),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account ?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Loginscreen()));
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
