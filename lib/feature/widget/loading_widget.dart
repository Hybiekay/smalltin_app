import 'package:flutter/material.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(child: Loading());
  }
}
