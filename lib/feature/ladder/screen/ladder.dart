import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/ladder/controller/ladder_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/widget/user_card.dart';

class Ladder extends StatelessWidget {
  const Ladder({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final ladderController = Get.find<LadderController>();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (ladderController.hasMore.value &&
            !ladderController.isLoading.value) {
          ladderController.fetchUsers();
        }
      }
    });

    return GetBuilder<LadderController>(builder: (ladderController) {
      return AppScaffold(
        child: RefreshIndicator(
          onRefresh: () async {
            await ladderController.realtimeUpdate();
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Obx(() {
              return ListView.builder(
                controller: scrollController,
                itemCount: ladderController.users.length +
                    (ladderController.hasMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < ladderController.users.length) {
                    return UserCard(user: ladderController.users[index]);
                  } else {
                    return Obx(() {
                      if (ladderController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    });
                  }
                },
              );
            }),
          ),
        ),
      );
    });
  }
}
