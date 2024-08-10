import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/apis/chat.dart';
import 'package:smalltin/model/user_model.dart';
import '../model/message.dart';

class ChatController extends GetxController {
  ChatApi chatApi = ChatApi();
  final box = GetStorage();

  // Reactive variable to store a list of message objects
  var messages = <Message>[].obs;

  // Method to get messages
  getMessages() async {
    try {
      var fetchedMessages = await chatApi.getConversation();
      messages.value = fetchedMessages; // This should now be a List<Message>
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  // Method to send a message to the admin
  sendMessageToAdmin(String message) async {
    try {
      var ff = box.read("user");
      if (ff != null) {
        log("not null");
        UserModel userRessponse = UserModel.fromJson(ff);
        Sender sender = Sender(
            username: userRessponse.username,
            email: userRessponse.email,
            role: "user");
        var messagemodel = Message(
            senderType: "App\\Models\\User",
            message: message,
            createdAt: DateTime.now().toIso8601String(),
            updatedAt: DateTime.now().toIso8601String(),
            sender: sender);
        messages.insert(0, messagemodel);
        var sentMessage = await chatApi.sendMessage(message: message);
        if (sentMessage != null) {
          // Assuming sentMessage is a Map<String, dynamic>
        }
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}
