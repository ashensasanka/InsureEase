import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Insurees', lastName: 'Kularathne');

  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'Insureese', lastName: 'BOT');

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_messages.isEmpty)
              Column(
                children: [
                  Center(
                    child: Container(
                      width: 500,
                      height: 350,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/message.png'),
                          Text(
                              'Hi ! How can I help you?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),

                    ),
                  ),
                  Container(
                    width: 500,
                    height: 100,
                    child: DashChat(
                      currentUser: _currentUser,
                      typingUsers: _typingUsers,
                      messageOptions: const MessageOptions(
                        currentUserContainerColor: Colors.black,
                        containerColor: Color(0xffF09D21),
                        textColor: Colors.white,
                      ),
                      onSend: (ChatMessage m) {
                        getChatResponse(m);
                      },
                      messages: _messages,
                    ),
                  ),
                ],
              ),
        
            if (_messages.isNotEmpty)
              Container(
                width: 500,
                height: 650,
                child: DashChat(
                  currentUser: _currentUser,
                  typingUsers: _typingUsers,
                  messageOptions: const MessageOptions(
                    currentUserContainerColor: Colors.black,
                    containerColor: Color(0xffF09D21),
                    textColor: Colors.white,
                  ),
                  onSend: (ChatMessage m) {
                    getChatResponse(m);
                  },
                  messages: _messages,
                ),
              ),
          ],
        ),
      ),
    );
  }


  Future<void> getChatResponse(ChatMessage m) async {
    setState(
      () {
        _messages.insert(0, m);
        _typingUsers.add(_gptChatUser);
      },
    );
    List<Messages> _messagesHistory = _messages.reversed.map(
      (m) {
        if (m.user == _currentUser) {
          return Messages(role: Role.user, content: m.text);
        } else {
          return Messages(role: Role.assistant, content: m.text);
        }
      },
    ).toList();
    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: _messagesHistory,
      maxToken: 100,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(
          () {
            _messages.insert(
              0,
              ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content),
            );
          },
        );
      }
    }
    setState(
      () {
        _typingUsers.remove(_gptChatUser);
      },
    );
  }
}
