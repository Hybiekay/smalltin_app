import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/contact_us/controllers/chat_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../model/message.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatController.getMessages();
    chatController.messages.listen((_) {
      // Scroll to the bottom when new messages arrive
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      chatController.sendMessageToAdmin(message);
      _messageController.clear();
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbarTitle: Row(
        children: [
          CircleAvatar(
              // You can set an image here if needed
              ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Care",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Admin",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              // Ensure messages are loaded and correctly formatted
              if (chatController.messages.isEmpty) {
                return Center(child: Text("No messages yet"));
              }

              return ListView.builder(
                reverse: true, // Display items in reverse order
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  final isUserMessage =
                      message.senderType == 'App\\Models\\User';
                  final senderName = message.sender.username;
                  final messageText = message.message;
                  final createdAt = DateTime.parse(message.createdAt);
                  final formattedDate = timeago.format(createdAt);

                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            isUserMessage ? Colors.grey[200] : Colors.blue[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: isUserMessage
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Text(
                            messageText,
                            style: TextStyle(
                                color: isUserMessage
                                    ? Colors.black
                                    : Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "$senderName • $formattedDate",
                            style: TextStyle(
                              fontSize: 10,
                              color: isUserMessage
                                  ? Colors.black54
                                  : Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
