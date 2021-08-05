import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_chat_app/constants.dart';
import 'package:simple_chat_app/screens/welcome_screen.dart';
import 'package:simple_chat_app/services/save_data_services.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message;
  UserDataServices _userDataServices = UserDataServices();
  var messages = FirebaseFirestore.instance.collection('message').orderBy('posted_at',descending: true).snapshots();
  User currentUser = FirebaseAuth.instance.currentUser;
  var messageController = TextEditingController();
bool isAdmin=true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan.shade800,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: StreamBuilder<QuerySnapshot>(
                    stream: messages,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("No Chats Yet"));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }


                      return ListView(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data.docs
                            .map((DocumentSnapshot document) {
                          final senderEmail = document['sender'];
                          final currentUserEmail = currentUser.email;
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment:
                              senderEmail == currentUserEmail
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      document['message'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                // Bubble(
                                //   margin: BubbleEdges.only(top: 5),
                                //   alignment: Alignment.topLeft,
                                //   nipWidth: 30,
                                //   nipHeight: 10,
                                //   nip: BubbleNip.leftTop,
                                //   child: Text(document['message'],style: TextStyle(color:Colors.black),),
                                // ),
                                Text(
                                  document['posted_at'].toString(),
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );

                    }),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: TextStyle(color: Colors.black),
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        message = messageController.text;
                      });
                      if(messageController.text.isEmpty){
                        return null;
                      }
                      _userDataServices.addUserData(messages: message);
                      setState(() {
                        messageController.text = '';
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.telegram,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
