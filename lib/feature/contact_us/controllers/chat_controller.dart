import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/core/constants/api_string.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:smalltin/apis/chat.dart';
import 'package:smalltin/model/user_model.dart';
import '../../../controller/user_controller.dart';
import '../model/message.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true);
  String? typingUser;
  final UserModel? user = Get.put(UserController()).userModel;
  ChatApi chatApi = ChatApi();
  final box = GetStorage();
  io.Socket socket = io.io(
      ApiString.socketUrl(),
      io.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build());

  var messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    messageController.addListener(_onMessageChanged);
    var token = box.read("token");
    log('Token fetched: $token');

    _connectSocket();
    socket.connect();
    listenToStopTyping();
    listenToTyping2();
    receiveMessages();
    getMessages();

    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
  }

  void _onMessageChanged() {
    if (messageController.text.isEmpty) {
      stopTyping();
    } else {
      // You can add a debounce here to detect inactivity (e.g., user stopped typing)
      // Debounce duration example:
      debounce(messageController.text.obs, (_) {
        stopTyping();
      }, time: Duration(seconds: 1));
    }
  }

  void sendMessage() {
    final message = messageController.text;
    if (message.isNotEmpty) {
      stopTyping();
      Sender sender = Sender(
          username: user?.username ?? '',
          email: user?.email ?? "",
          role: "user");
      var messageModel = Message(
          senderType: "App\\Models\\User",
          message: message,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          sender: sender);
      messages.insert(0, messageModel);
      sendMessageToAdmin(message);
      messageController.clear();

      socket.emit("message", [
        user?.id,
        messageModel.toJson(),
      ]);
      Future.delayed(const Duration(milliseconds: 50), () {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.minScrollExtent);
        }
      });
    }
  }

  _connectSocket() {
    socket.onConnect((data) {
      log("Connected");
      socket.emit('conversation', user?.id);

      socket.on('newMessage', (data) {
        log('New message received: $data');
        Message message = Message.fromJson(data);
        messages.insert(0, message);
      });
    });

    socket.onConnectError((data) => log("Error in connection $data"));
    socket.onDisconnect((data) => log("Socket io is disconnected"));
  }

  startTyping() {
    socket.emit("typing", [user?.id, user?.toJson()]);
  }

  stopTyping() {
    socket.emit("stopTyping", user?.id);
  }

  receiveMessages() {
    log('receiveMessage');
    socket.on('message/${user?.id}', (data) {
      log('receiveMessage');

      var sender = Sender(
          username: data["sender"]["username"] ?? "",
          email: data["sender"]["email"] ?? " ",
          role: "Admin");
      Message message = Message(
        id: messages.length + 1,
        createdAt: data["created_at"] ?? DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        senderType: "Admin",
        message: data["message"] ?? "hello",
        sender: sender,
      );

      messages.insert(0, message);
    });
  }

  getMessages() async {
    try {
      var fetchedMessages = await chatApi.getConversation();
      messages.value = fetchedMessages;
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  sendMessageToAdmin(String message) async {
    try {
      var ff = box.read("user");
      if (ff != null) {
        var sentMessage = await chatApi.sendMessage(message: message);
        if (sentMessage != null) {
          // Assuming sentMessage is a Map<String, dynamic>
        }
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  listenToTyping2() {
    socket.on("typing/${user?.id}", (data) {
      log("User ${data['username']} is typing in chat2 ");
      typingUser = "${data['fullname']} is typing";
      update();
    });
  }

  listenToStopTyping() {
    socket.on("stopTyping/${user?.id}", (s) {
      typingUser = null;
      update();
    });
  }

  @override
  void onClose() {
    socket.dispose();
    messageController.dispose();
    scrollController.dispose();
    stopTyping();
    super.onClose();
  }
}
