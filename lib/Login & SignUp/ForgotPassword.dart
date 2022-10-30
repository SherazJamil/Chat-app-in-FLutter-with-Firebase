import 'package:chat_app/Login%20&%20SignUp/Login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final emailEditingController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future resetPassword() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
      height:50,
      width: 50,
      child: const SpinKitChasingDots(
        color: Colors.deepOrange,
      ),
    ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailEditingController.text.trim());
      final snackBar = SnackBar(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(15),
        content: const Text(
          'Reset Password Email has been sent',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch(e) {
      print(e);
      final snackBar = SnackBar(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(15),
        content: const Text(
          'Error Occured',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    gradient: LinearGradient(
                        colors: [Color(0xffffa500), Colors.deepOrangeAccent]),
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
                        "F",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Text(
                      "O",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "R",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "G",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "O",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "T",
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
                      "P",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "A",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "S",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "S",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "W",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "O",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "R",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "D",
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
              Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: InkWell(
                        onTap: () {
                          resetPassword();
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const Loginscreen() ));
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
                              "Reset Password",
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                              "Go Back",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                    ),
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
