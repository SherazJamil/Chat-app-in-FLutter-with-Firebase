import 'package:chat_app/Login%20&%20SignUp/SignUp.dart';
import 'package:chat_app/Screens/ChatHome.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Authentication Methods/Methods.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
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
                              "L",
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
                            "G",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
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
                            "N",
                            style: TextStyle(
                              color: Colors.black,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formkey,
                      child: Column(
                        children: [
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
                                  if (emailEditingController.text.isNotEmpty &&
                                      passwordEditingController
                                          .text.isNotEmpty) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    Login(emailEditingController.text,
                                            passwordEditingController.text)
                                        .then((user) {
                                      if (user != null) {
                                        print("Login Sucessfull");
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (_) => const Chathome() ));
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      duration: const Duration(seconds: 2),
                                      margin: const EdgeInsets.all(15),
                                      content: const Text(
                                        'Fill the form correctly',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.deepOrange,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
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
                                    "Login",
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
                          InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(right: 18.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Forgot Password ?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 60.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account ?",
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
                                                const SignUpscreen()));
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 15,
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