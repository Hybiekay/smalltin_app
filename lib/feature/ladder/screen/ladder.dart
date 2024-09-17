import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/ladder/controller/ladder_controller.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/widget/user_card.dart';

import '../../../controller/user_controller.dart';

class Ladder extends StatefulWidget {
  const Ladder({super.key});

  @override
  LadderState createState() => LadderState();
}

class LadderState extends State<Ladder> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final LadderController ladderController = Get.find<LadderController>();
    final UserController userController = Get.find<UserController>();

    // Method to scroll to the current user
    void scrollToCurrentUser() {
      final currentUserIndex = ladderController.users.indexWhere(
          (user) => user.userDetails.email == userController.userModel!.email);
      if (currentUserIndex != -1) {
        // Scroll to the current user's position
        scrollController.animateTo(
          currentUserIndex *
              80.0, // Assuming each card has a height of around 80
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    }

    // Filter the remaining users based on the search query
    List<MonthlyStat> remainingUsers = ladderController.users.length > 3
        ? ladderController.users.sublist(3)
        : [];

    List<MonthlyStat> filteredUsers = remainingUsers.where((user) {
      final username = user.userDetails.username.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return username.contains(query);
    }).toList();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (ladderController.hasMore.value &&
            !ladderController.isLoading.value) {
          ladderController.fetchUsers();
        }
      }
    });

    return AppScaffold(
      child: Column(
        children: [
          // Row for the search bar and button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search by name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: scrollToCurrentUser,
                  child: const Text('Go to My Position'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => RefreshIndicator(
                  onRefresh: () async {
                    await ladderController.realtimeUpdate();
                  },
                  child: ListView(
                    controller: scrollController,
                    children: [
                      if (ladderController.users.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              // Display Top Three Users
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (ladderController.users.length > 1)
                                    _buildUserAvatar(
                                      ladderController
                                          .users[1].userDetails.profile,
                                      '2nd',
                                      ladderController
                                          .users[1].userDetails.username,
                                      ladderController.users[1].correctAnswers,
                                      40,
                                      context,
                                      ladderController
                                              .users[1].userDetails.email ==
                                          userController.userModel!.email,
                                    ),
                                  if (ladderController.users.isNotEmpty)
                                    _buildUserAvatar(
                                      ladderController
                                          .users[0].userDetails.profile,
                                      '1st',
                                      ladderController
                                          .users[0].userDetails.username,
                                      ladderController.users[0].correctAnswers,
                                      60,
                                      context,
                                      ladderController
                                              .users[0].userDetails.email ==
                                          userController.userModel!.email,
                                    ),
                                  if (ladderController.users.length > 2)
                                    _buildUserAvatar(
                                      ladderController
                                          .users[2].userDetails.profile,
                                      '3rd',
                                      ladderController
                                          .users[2].userDetails.username,
                                      ladderController.users[2].correctAnswers,
                                      40,
                                      context,
                                      ladderController
                                              .users[2].userDetails.email ==
                                          userController.userModel!.email,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      // Remaining Users (Filtered)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          final isCurrentUser = user.userDetails.email ==
                              userController.userModel!.email;
                          return UserCard(
                            user: user,
                            isCurrentUser: isCurrentUser,
                          );
                        },
                      ),
                      // Loading Indicator
                      if (ladderController.hasMore.value &&
                          ladderController.isLoading.value)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  // Helper function to build the user avatar with name, correct attempts, and rank
  Widget _buildUserAvatar(
    String? profileUrl,
    String rank,
    String name,
    int correctAttempts,
    double radius,
    BuildContext context,
    bool isCurrentUser,
  ) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: radius, // Dynamic radius
              backgroundImage: NetworkImage(profileUrl ?? ""),
              backgroundColor:
                  isCurrentUser ? Colors.green.withOpacity(0.2) : null,
            ),
            Positioned(
              bottom: -5,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.green, // Ladder color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  rank,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        // User's name and correct attempts section with responsive width
        SizedBox(
          width: MediaQuery.of(context).size.width / 3 - 20,
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCurrentUser ? Colors.green : null,
                ),
                textAlign: TextAlign.center,
              ),
              // Correct attempts
              Text(
                'Correct Attempts: $correctAttempts',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
