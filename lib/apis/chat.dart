import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/feature/contact_us/model/message.dart';

class ChatApi {
  final box = GetStorage();

  Future<List<Message>> getConversation() async {
    var token = box.read("token");
    try {
      var res = await http.get(
        ApiString.endPoint("chats"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
          //'X-API-KEY': ApiString.apiquiss,
        },
      );
      debugPrint(res.statusCode.toString());
      log(res.body.toString());

      var response = json.decode(res.body);
      var data = response["data"] as List<dynamic>; // Ensure data is a List<dynamic>

      // Convert dynamic list to List<Message>
      return data.map((msg) => Message.fromJson(msg as Map<String, dynamic>)).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future sendMessage({required String message}) async {
    var token = box.read("token");
    try {
      var res = await http.post(ApiString.endPoint("message"), headers: {
        "accept": "application/json",
        "Authorization": "Bearer $token",
        //'X-API-KEY': ApiString.apiquiss,
      }, body: {
        "message": message
      });
      debugPrint(res.statusCode.toString());
      log(res.body.toString());
      var response = json.decode(res.body);

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
