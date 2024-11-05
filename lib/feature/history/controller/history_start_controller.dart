import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/feature/history/model/history_stat.dart';

class HistoryStatController extends GetxController {
  var historyStat = <HistoryStat>[].obs; // Observable list of HistoryStat
  var isLoading = true.obs; // Loading state

  final box = GetStorage();

  @override
  void onInit() {
    fetchMonthlyStats(); // Fetch monthly stats on initialization
    super.onInit();
  }

  Future<void> fetchMonthlyStats() async {
    isLoading.value = true; // Set loading state to true
    var token = box.read("token");
    log("Start: $token");

    try {
      var response = await http.get(
        ApiString.endPoint("monthly-stats"), // Update with your actual endpoint
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        log("Response data: ${data['data']}");

        // Clear previous data
        historyStat.clear();

        // Parse and add new data to the observable list
        for (var item in data['data']) {
          historyStat.add(HistoryStat.fromJson(item));
        }
      } else {
        log("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }
}
