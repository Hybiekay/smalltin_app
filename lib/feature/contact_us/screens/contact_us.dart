import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/controller/user_controller.dart';
import 'package:smalltin/feature/contact_us/controllers/chat_controller.dart';
import 'package:smalltin/model/user_model.dart';
import 'package:smalltin/themes/color.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../widget/app_scaffold.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String? typingUser;
  final UserModel? user = Get.put(UserController()).userModel;
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    chatController.messages.listen((_) {
      Future.delayed(const Duration(milliseconds: 50), () {
        if (chatController.scrollController.hasClients) {
          debugPrint("object");
          chatController.scrollController
              .jumpTo(chatController.scrollController.position.minScrollExtent);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbarTitle: GetBuilder<ChatController>(builder: (chat) {
        return Row(
          children: [
            const CircleAvatar(
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
                  chat.typingUser ?? "Admin",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        );
      }),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              // Ensure messages are loaded and correctly formatted
              if (chatController.messages.isEmpty) {
                return const Center(child: Text("No messages yet"));
              }

              return ListView.builder(
                reverse: true, // Display items in reverse order
                controller: chatController.scrollController,
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
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? Colors.grey[200]
                            : AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: isUserMessage
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
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
                    onChanged: (v) {
                      if (v == "") {
                        chatController.stopTyping();
                      } else {
                        chatController.startTyping();
                      }
                    },
                    controller: chatController.messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
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
                  onPressed: chatController.sendMessage,
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
