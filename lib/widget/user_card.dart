import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:smalltin/themes/color.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Victor Patrick",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "The best you can do is to try more \n09010221325, hybiekay@gmail.com",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                "Q: 12K C: 12k W: 1000",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
