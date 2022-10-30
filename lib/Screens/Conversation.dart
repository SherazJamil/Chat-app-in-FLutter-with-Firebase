import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ConversationScreen extends StatelessWidget {

  late final Map<String, dynamic> userMap;
  late final String chatRoomId;

  ConversationScreen({Key? key, required this.chatRoomId,required this.userMap}) : super(key: key);

  File? image;

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //     );
  //     if (image == null) return;
  //     final imageTemporary = File(image.path);
  //     setState(() => this.image = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  final msgEditingController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (msgEditingController.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "isSendbyMe": auth.currentUser!.displayName,
        "message": msgEditingController.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      msgEditingController.clear();

      await firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title:  Text(
          userMap['name'],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
           Expanded(
            child: StreamBuilder<QuerySnapshot> (
              builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return GroupedListView<dynamic,DateTime>(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    elements: snapshot.data?.docs as List<dynamic>,
                    groupBy: (message) => DateTime(
                      message.date.year,
                      message.date.month,
                      message.date.day,
                    ),
                    groupHeaderBuilder: (messages) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: Colors.deepOrange,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(messages.date),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context,  messages) => Align(
                      alignment: messages.isSendbyMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: messages.isSendbyMe
                              ? const BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                              bottomLeft: Radius.circular(23))
                              : const BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                              bottomRight: Radius.circular(23)),
                        ),
                        color: messages.isSendbyMe
                            ? Colors.deepOrange
                            : Colors. white,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(messages.text,
                            style: TextStyle(
                              color: messages.isSendbyMe
                                  ? Colors.white
                                  : Colors. black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
      ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 450,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      cursorColor: Colors.deepOrange,
                      decoration: InputDecoration(
                          hintText: "Type here...",
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                          fillColor: Colors.grey.shade300,
                          filled: true,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.message,
                            color: Colors.black,
                            size: 20,
                          ),
                          suffixIcon:  IconButton(
                            color: Colors.white38,
                            onPressed: () => {},
                            icon: const Icon(
                              FontAwesomeIcons.solidImage,
                              color: Colors.black,
                              size: 20,
                            ),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    onSendMessage();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffffa500), Colors.deepOrangeAccent],),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}