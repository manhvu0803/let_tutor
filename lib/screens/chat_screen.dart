import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:let_tutor/screens/screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const _user = types.User(id: 'user');
  static const _chatGpt = types.User(id: 'assistant');
  static const _client = types.User(id: 'client');

  final List<types.Message> _messages = [];
  final List<Map<String, String>> prompts = [];
  late OpenAI _openAi;
  bool _isAiTyping = false;

  // Init OpenAI in here because global init produce error (probally due to lazy initialization)
  @override
  void initState() {
    super.initState();

    _openAi = OpenAI.instance.build(
      token: dotenv.env["api_key"],
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 90)),
      enableLog: true
    );

    var now = DateTime.now().millisecondsSinceEpoch;

    _messages.add(types.TextMessage(
      author: _chatGpt,
      createdAt: now,
      id: now.toString(),
      text: "Hello, how can I help you today?",
    ));

    prompts.add({"role": _user.id, "content": "Keep it short and simple"});
    prompts.add({"role": _chatGpt.id, "content": "Okay"});
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      padding: 0,
      useAppBar: true,
      appBarTitle: "Chat with ChatGPT",
      child: Chat(
        isAttachmentUploading: _isAiTyping,
        messages: _messages,
        onSendPressed: _onSendButtonPressed,
        user: _user,
        customMessageBuilder: (message, {required messageWidth}) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextMessage(
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
              hideBackgroundOnEmojiMessages: true,
              message: types.TextMessage(
                author: message.author,
                id: message.id,
                text: message.metadata?["text"] ?? "Error building message"
              ),
              showName: false,
              usePreviewData: false
            )
          ],
        )
      )
    );
  }

  void _onSendButtonPressed(types.PartialText message) async {
    setState(() {
      _messages.insertAll(0, [
        _buildMessage("_chatGPT is typing..._", author: _client),
        _buildMessage(message.text)
      ]);

      _isAiTyping = true;
    });

    prompts.add({"role": _user.id, "content": message.text});

    final request = ChatCompleteText(
      maxToken: 400,
      messages: prompts,
      model: ChatModel.gptTurbo0301,
    );

    try {
      final response = await _openAi.onChatCompletion(request: request);
      final responseText = response!.choices[0].message!.content;
      prompts.add({"role": _chatGpt.id, "content": responseText});
      _replaceLastMessage(_buildResponse(responseText.replaceAll("```", "`")));
    }
    catch (error) {
      _replaceLastMessage(_buildMessage("Error with contacting the server, please try again later", author: _client));
    }
  }

  void _replaceLastMessage(types.Message message) {
    setState(() {
      _messages[0] = message;
      _isAiTyping = false;
    });
  }

  types.Message _buildMessage(String text, {types.User? author, int? time}) {
    time ??= DateTime.now().millisecondsSinceEpoch;
    author ??= _user;

    return types.TextMessage(
      author: author,
      createdAt: time,
      id: time.toString(),
      text: text,
    );
  }

  types.Message _buildResponse(String text, {int? time}) {
    time ??= DateTime.now().millisecondsSinceEpoch;

    return types.CustomMessage(
      author: _chatGpt,
      createdAt: time,
      id: time.toString(),
      metadata: { "text" : text }
    );
  }
}