import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/view/widget/app_bar_widget.dart';

class GhiblianScreen extends StatefulWidget {
  const GhiblianScreen({super.key});

  @override
  State<GhiblianScreen> createState() => _GhiblianScreenState();
}

class _GhiblianScreenState extends State<GhiblianScreen> {
  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "Hasna",
    profileImage: "https://i.pravatar.cc/150?img=1",
  );

  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Ghiblian",
    profileImage:
        "https://i.pinimg.com/736x/52/5f/4e/525f4e461721696d958b58350da1af8d.jpg",
  );

  List<ChatMessage> messages = [];

  final Gemini gemini = Gemini.instance;

  void sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages.insert(0, chatMessage);
    });

    try {
      String question = chatMessage.text;

      if (chatMessage.medias?.isNotEmpty == true) {}
      gemini
          .streamGenerateContent(
        question,
      )
          .listen(
        (event) {
          ChatMessage? lastMessage = messages.firstOrNull;

          if (lastMessage != null && lastMessage.user == geminiUser) {
            lastMessage = messages.removeAt(0);
            String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) => "$previousValue${element.text}",
                ) ??
                "";

            lastMessage.text += response;

            setState(() {
              messages.insert(0, lastMessage!);
            });
          } else {
            String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) => "$previousValue${element.text}",
                ) ??
                "";

            ChatMessage message = ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: response,
            );

            setState(() {
              messages.insert(0, message);
            });
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo.png",
            width: 100,
          ),
          backgroundColor: kbackgroundColor,
          actions: const [AppbarWidget(), SizedBox(width: 20)],
        ),
        body: DashChat(
            currentUser: currentUser, onSend: sendMessage, messages: messages));
  }
}
