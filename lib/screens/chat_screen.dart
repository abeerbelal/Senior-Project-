import 'package:flutter/material.dart';
import 'package:chat_test/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ChatScreen extends StatefulWidget {
  static const String id='Chat_Screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController =TextEditingController();
  final _auth=FirebaseAuth.instance;
  final _firestor=FirebaseFirestore.instance;
  late User loggedInUser;
  late String messageText;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final user =await _auth.currentUser;
      if(user !=null){
        loggedInUser=user;
        print(loggedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }
  
  // void getMessages() async{
  //   final messages= await _firestor.collection("Messages").get();
  //    for(var message in messages.docs){
  //      print(message.data());
  //    }
  // }

   void messagesStream()async {
    // here we dealing with firebase query snapshot
     await for (var snapshot in _firestor.collection("Messages").snapshots()) {
       for (var message in snapshot.docs) {
         print(message.data());
       }
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
              //  getMessages();
                // //Implement logout functionality
                // _auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[             // we working with async snapshot
            StreamBuilder<QuerySnapshot>(
              stream: _firestor.collection("Messages").snapshots(),
                builder:(context,snapshot){
                List<MessageBubble>messagesWidgets=[];
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
                final messages=(snapshot.data! as QuerySnapshot).docs.map((e) {
                  final messageText=e['text'];
                  final messageSender=e['sender'];
                  final currentUser=loggedInUser.email;
                  if(currentUser== messageSender){
                    //the message from the logged in user

                  }

                  final messageBubble =MessageBubble(
                      sender:messageSender,
                      text: messageText,
                  isMe: currentUser==messageSender);
                  messagesWidgets.add(messageBubble);
                }).toList().reversed;

              return Expanded(
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                  children: messagesWidgets,
                ),
              );

            },

            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //Implement send functionality.
                      messageTextController.clear();
                      //messageText+loggedInUser.email
                      //add method takes a map
                      await _firestor.collection("Messages").add({//creat a map and fill it by fields in firestore
                      'text':messageText,
                      'sender':loggedInUser.email,
                      });

                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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
class MessageBubble extends StatelessWidget {
   final String sender;
   final String text;
   final bool isMe;
 MessageBubble({required this.sender,required this.text, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
          ),
          Material(
            borderRadius:isMe? BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft:Radius.circular(30.0) ,
              bottomRight: Radius.circular(30.0)
            ): BorderRadius.only(
              bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),topRight: Radius.circular(30.0)
            ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Text(
                '$text from $sender',
                style: TextStyle(
                  color: isMe? Colors.white: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
