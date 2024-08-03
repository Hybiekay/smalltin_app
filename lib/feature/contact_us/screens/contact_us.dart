import 'package:flutter/material.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appbarTitle: Row(
        children: [
          CircleAvatar(),
          Column(
            children: [
              Text("Ademola Ibukun"),
              Text("Developer"),
            ],
          )
        ],
      ),
    );
  }
}
