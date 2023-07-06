import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/message.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  String fieldData = '';
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.FromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: KPrimaryColor,
                centerTitle: true,
                title: Row(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(
                    KLogo,
                    width: 80,
                    height: 80,
                  ),
                  Text('Chat'),
                ]),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) => messagesList[index].id ==
                              email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(message: messagesList[index])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (data) {
                      fieldData = data;
                    },
                    controller: controller,
                    onSubmitted: (data) {
                      if (!data.isEmpty) {
                        messages.add({
                          KMessage: data,
                          KCreatedAt: DateTime.now(),
                          KId: email,
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      } else {}
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (fieldData.isNotEmpty) {
                              messages.add({
                                KMessage: fieldData,
                                KCreatedAt: DateTime.now(),
                                KId: email,
                              });
                              fieldData = '';
                              controller.clear();
                              _controller.animateTo(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                            } else {}
                          },
                          icon: Icon(Icons.send)),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KPrimaryColor),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return Scaffold(
              backgroundColor: KPrimaryColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 30),
                  ),
                  SpinKitWave(
                    color: Colors.white,
                    size: 50,
                  )
                ],
              ),
            );
          }
        });
  }
}
