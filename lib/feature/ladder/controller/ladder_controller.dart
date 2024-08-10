import 'dart:developer';

import 'package:get/get.dart';
import 'package:smalltin/apis/ladder_api.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';

class LadderController extends GetxController {
  final LadderApi _ladderApi = LadderApi();
  var users = <MonthlyStat>[].obs;
  var currentPage = 1;
  var isLoading = false.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isLoading.value) return;

    isLoading.value = true;
    if (isRefresh) {
      currentPage = 1;
      users.clear();
      hasMore.value = true;
    }

    log("Fetching users: Page $currentPage");
    try {
      var response = await _ladderApi.getUsers(currentPage);

      log(response.toString());

      if (response != null && response.data.isNotEmpty) {
        users.addAll(response.data);
        currentPage++;
        isLoading.value = false;
      } else {
        hasMore.value = false;
      }
    } catch (error) {
      log("Error fetching users: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> realtimeUpdate() async {
    await fetchUsers(isRefresh: true);
  }
}
