import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/controller/user_controller.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/choose_field/choose_fields.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/home/widget/drawer.dart';
import 'package:smalltin/feature/ladder/controller/ladder_controller.dart';
import 'package:smalltin/feature/ladder/screen/ladder.dart';
import 'package:smalltin/feature/questions/screens/question.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/model/user_model.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/user_card.dart';
import '../../widget/appbar_button.dart';
import '../widget/dark_mode_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        DrawerScreen(),
        FrontPage(),
      ],
    );
  }
}

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  double xOffSet = 0;
  double yOffSet = 0;
  bool isDrawerOpen = false;
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  final LadderController ladderController = Get.put(LadderController());

  @override
  void initState() {
    userController.refreshUser();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FrontPage oldWidget) {
    userController.refreshUser();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
        ..scale(isDrawerOpen ? 0.87 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: const Duration(milliseconds: 300),
      child: GetBuilder<UserController>(builder: (ucontroller) {
        UserModel? user = ucontroller.userModel;
        return GetBuilder<LadderController>(builder: (ladderController) {
          // Get the first user in the ladder list, if available
          var firstUser = ladderController.users.isNotEmpty
              ? ladderController.users[0]
              : null;

          return AppScaffold(
            leadingWidth: 1,
            appbarLeading: Container(),
            appbarTitle: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      if (isDrawerOpen) {
                        setState(() {
                          xOffSet = 0;
                          yOffSet = 0;
                          isDrawerOpen = false;
                        });
                      } else {
                        setState(() {
                          xOffSet = 290;
                          yOffSet = 80;
                          isDrawerOpen = true;
                        });
                      }
                    },
                    child: isDrawerOpen
                        ? Container(
                            decoration: const BoxDecoration(
                              color: AppColor.pColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColor.white,
                                ),
                              ),
                            ))
                        : const CircleAvatar()),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalizeFirstLetter(
                        user?.username ?? "Welcome",
                      ),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: !context.isDarkMode ? AppColor.gray : null,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        user?.fields.isNotEmpty == true
                            ? user!.fields
                                .map((e) => e.name)
                                .toList()
                                .join(", ")
                            : "No fields available",
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColor.gray, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            appbarActions: [
              const DarkModeSwitch(),
              AppBarButton(
                title: "Total Job\$",
                subTitle: "${user?.jobs} \$",
              )
            ],
            child: RefreshIndicator(
              onRefresh: () async {
                await ucontroller.refreshUser();
                await ladderController.realtimeUpdate();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                        "Total Question Attempt: ${user?.totalQuestionAttempt}"),
                    Text(
                      "Total Question Correct: ${user?.totalQuestionCorrect}",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BoxCard(
                          text: "Attempt",
                          onTap: () {
                            Get.to(() => const Question());
                          },
                          isButton: true,
                        ),
                        BoxCard(
                          text: "Total  Q Attempt",
                          subText: "${user?.totalQuestionAttempt}",
                        ),
                        BoxCard(
                          text: "Total  Correct",
                          subText: "${user?.totalQuestionCorrect}",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 180,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColor.pColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CardButton(
                                text: "First Position",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                user?.id == firstUser?.userDetails.id
                                    ? "You Are taking the first Position \nKeep it Going"
                                    : "You Are Not the First \nPosition. Try to Answer \nmore questions to beat it",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColor.gray,
                                      fontSize: 10,
                                    ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const CircleAvatar(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalizeFirstLetter(
                                            firstUser?.userDetails.username ??
                                                "No user"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: AppColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                          text: "Job\$ ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColor.gray),
                                        ),
                                        TextSpan(
                                          text: firstUser != null
                                              ? " ${firstUser.correctAnswers * 50} +"
                                              : "0",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColor.gray),
                                        )
                                      ]))
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CardButton(
                                text: "Edit Fields",
                                onTap: () {
                                  Get.to(() => const ChooseField());
                                },
                              ),
                              const SizedBox(height: 10),
                              ViewButton(
                                text: "View All",
                                isTop: true,
                                onTap: () {
                                  Get.to(() => const Ladder());
                                },
                              ),
                              const SizedBox(height: 13),
                              ViewButton(
                                text: "View In Position",
                                onTap: () {
                                  Get.to(() => const Ladder());
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Realtime result",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const Ladder());
                          },
                          child: Text(
                            "View All",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.7,
                      child: ListView.builder(
                          itemCount: ladderController.users.length,
                          itemBuilder: (context, index) {
                            var ladderUser = ladderController.users[index];
                            return UserCard(user: ladderUser);
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}

class ViewButton extends StatelessWidget {
  final bool isTop;
  final String text;
  final VoidCallback? onTap;
  const ViewButton({
    super.key,
    this.isTop = false,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 120,
        decoration: BoxDecoration(
            color: AppColor.scaffoldBg,
            borderRadius: isTop
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: !context.isDarkMode ? AppColor.white : null),
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const CardButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 120,
        decoration: BoxDecoration(
          color: AppColor.scaffoldBg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: !context.isDarkMode ? AppColor.white : null),
          ),
        ),
      ),
    );
  }
}

class BoxCard extends StatelessWidget {
  final String text;
  final String? subText;
  final VoidCallback? onTap;
  final bool isButton;
  const BoxCard(
      {super.key,
      this.isButton = false,
      this.subText,
      this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 110,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: isButton
            ? Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: !context.isDarkMode ? AppColor.white : null),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: !context.isDarkMode ? AppColor.white : null),
                  ),
                  Text(
                    subText ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: !context.isDarkMode ? AppColor.white : null),
                  ),
                ],
              ),
      ),
    );
  }
}
