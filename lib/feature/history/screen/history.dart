import 'package:flutter/material.dart';
import 'package:smalltin/feature/history/widget/monthly_stat_card.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';

import '../controller/history_start_controller.dart';

class HistoryStat extends StatefulWidget {
  const HistoryStat({super.key});

  @override
  State<HistoryStat> createState() => _HistoryStatState();
}

class _HistoryStatState extends State<HistoryStat> {
  final HistoryStatController monthlyStatController =
      Get.put(HistoryStatController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbarTitle: Text(
        'Monthly Stats',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      child: Obx(() {
        // Use Obx to reactively listen to changes in monthlyStats
        if (monthlyStatController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: monthlyStatController.historyStat.length,
          itemBuilder: (context, index) {
            final stat = monthlyStatController.historyStat[index];
            return MonthlyStatCard(
              historyStat: stat, // Pass the specific MonthlyStat object
            );
          },
        );
      }),
    );
  }
}
