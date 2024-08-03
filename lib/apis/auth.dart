import 'dart:async';
import 'dart:convert';

import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';

class AuthService {
  Future<http.Response?> login(String email) async {
    try {
      var res = await http.post(
        ApiString.endPoint("login"),
        headers: {"accept": "application/json"},
        body: {"email": email},
      );
      debugPrint(res.statusCode.toString());
      log(res.body);
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> loginWithPassword(
    String email,
    String password,
  ) async {
    try {
      var res = await http.post(
        ApiString.endPoint("password"),
        headers: {"accept": "application/json"},
        body: {"email": email, "password": password},
      );
      debugPrint(res.statusCode.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> resendOtp(String email) async {
    try {
      var res = await http.post(
        ApiString.endPoint("resend-otp"),
        headers: {"accept": "application/json"},
        body: {"email": email},
      );
      debugPrint(res.statusCode.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> verifyOtp(String email, String token) async {
    try {
      var res = await http.post(
        ApiString.endPoint("verify-email"),
        headers: {"accept": "application/json"},
        body: {"email": email, "token": token},
      );
      debugPrint(res.statusCode.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> forgetPassword(String email) async {
    try {
      var res = await http.post(
        ApiString.endPoint("forget-password"),
        headers: {"accept": "application/json"},
        body: {
          "email": email,
        },
      );
      debugPrint(res.statusCode.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> updatePassword(
    String password,
    String passwordConfirmation,
    String token,
  ) async {
    try {
      var res = await http.post(
        ApiString.endPoint("update"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          "password": password,
          "password_confirmation": passwordConfirmation
        },
      );
      debugPrint(res.statusCode.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> updateName(String username, String token) async {
    try {
      var res = await http.post(
        ApiString.endPoint("update"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          "username": username,
        },
      );
      debugPrint(res.statusCode.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

  Future updateFields(
    final List<int> field,
    final String token,
  ) async {
    try {
      log("start");
      var res = await http.post(
        ApiString.endPoint("update"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "fields": field,
        }),
      );

      log(res.statusCode.toString());
      log(res.body.toString());
      log("end");
      return res;
    } catch (e) {
      log("$e");
      return null;
    }
  }

  Future updateSubFields(
    final List<int> subfield,
    final String token,
  ) async {
    try {
      log("start");
      var res = await http.post(ApiString.endPoint("update"),
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "sub_fields": subfield,
          }));

      log(res.statusCode.toString());
      log(res.body.toString());
      log("end");
      return res;
    } catch (e) {
      log("$e");
      return null;
    }
  }

  Future<http.Response?> getuser(
    final String token,
  ) async {
    var res = await http.get(
      ApiString.endPoint("user"),
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    debugPrint(res.statusCode.toString());
    debugPrint(res.body.toString());
    return res;
  }

  Future logout(
    final String token,
  ) async {
    try {
      var res = await http.get(
        ApiString.endPoint("logout"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      debugPrint(res.statusCode.toString());
      return res;
    } catch (e) {
      return null;
    }
  }
}
