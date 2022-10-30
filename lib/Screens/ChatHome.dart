import 'package:chat_app/Authentication%20Methods/Methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chathome extends StatefulWidget {
  const Chathome({Key? key}) : super(key: key);

  @override
  State<Chathome> createState() => _ChathomeState();
}

class _ChathomeState extends State<Chathome> {
  late Map<String, dynamic> userMap;
  final searchEditingController = TextEditingController();
  bool isLoading = false;

  void onSearch() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await  firestore.collection('users').where('email', isEqualTo: searchEditingController.text)
        .get().then((value) {
          setState(() {
            userMap = value.docs[0].data();
            isLoading = false;
          });
          print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        elevation: 20,
        title: const Text(
          'Mi Chat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<MenuItem>(
              onSelected: (value){
                if(value == MenuItem.item1){}
                if(value == MenuItem.item2){}
              },
              itemBuilder: (context) => [
             PopupMenuItem(
                value: MenuItem.item1,
                child: const Text('Settings'),
               onTap: () {},
            ),
                PopupMenuItem(
              value: MenuItem.item2,
              child: const Text('Log Out'),
              onTap: () => LogOut(context),
            )
          ])
        ],
      ),
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
          : ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: searchEditingController,
                  decoration: InputDecoration(
                      hintText: "Search here...",
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.black,
                        size: 20,
                      ),
                      suffixIcon:  IconButton(
                        color: Colors.white38,
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.black,
                          size: 20,
                        ),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              userMap != null ? ListTile(
                minVerticalPadding: 25,
                tileColor: Colors.deepOrangeAccent,
                leading: const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/Thor.png'),
                ),
                title: Text(
                  userMap['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  userMap['email'],
                ),
                trailing: const Icon(FontAwesomeIcons.solidMessage,
                  color: Colors.white,),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ConversationScreen()));
                },
              )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum MenuItem {
  item1,
  item2
}