import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/home_controller.dart';
import '../../Models/measurement.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/main_info.dart';
import '../../Widgets/secondary_info.dart';

class ViewMeasurement extends StatelessWidget {
  final Measurement measurement;

  const ViewMeasurement({
    super.key,
    required this.measurement,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: '${'measurement'.tr} ${measurement.fullName}',
            leadingExists: true,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainInfo(
                  bmr: measurement.bmr.toInt(),
                  weight: measurement.weight.toInt(),
                  activityLevel: controller.convertActivityLevelToBeDisplayed(
                    measurement.activityLevel,
                  ),
                  measurementSystem: controller.measurementSystem,
                  dashboard: false,
                  energyUnit: controller.energyUnit,
                ),
                const SizedBox(height: 40),
                SecondaryInfo(
                  protein: measurement.proteinInGrams.toInt(),
                  carbs: measurement.carbsInGrams.toInt(),
                  fat: measurement.fatInGrams.toInt(),
                  calories: measurement.calories.toInt(),
                  energyUnit: controller.energyUnit,
                  measurementSystem: controller.measurementSystem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
