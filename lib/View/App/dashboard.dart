import 'package:calories_calculator/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/home_controller.dart';
import 'package:calories_calculator/Widgets/app_bar.dart';
import 'package:calories_calculator/Widgets/main_info.dart';
import 'package:calories_calculator/Widgets/secondary_info.dart';
import 'package:calories_calculator/colors.dart';
import 'package:calories_calculator/Widgets/text.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        if (controller.fetchingUserData) {
          return Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: MyColors().myBlue,
                strokeWidth: 2,
              ),
            ),
          );
        } else if (!controller.fetchedUserData &&
            controller.completedCalculations) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MyText(
                text: 'Error fetching user data.',
                size: 16,
                weight: FontWeight.normal,
                color: Colors.black,
                align: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MyButton(
                buttonFunction: controller.getUserData,
                height: 40,
                width: 100.w,
                color: MyColors().myGreen,
                child: const MyText(
                  text: 'Try Again',
                  size: 16,
                  weight: FontWeight.normal,
                  color: Colors.white,
                ),
              )
            ],
          );
        } else {
          return SafeArea(
            child: Scaffold(
              appBar: MyAppBar(
                title: controller.currentUserData!.fullName,
                leadingExists: false,
                actionExists: true,
                icon: const Icon(Icons.account_circle),
                actionFunction: () {
                  controller.setInfoToOriginal();
                  Get.toNamed('/profile');
                },
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MainInfo(
                      bmr: controller.currentUserData!.bmr.toInt(),
                      weight: controller.currentUserData!.weight.toInt(),
                      activityLevel:
                          controller.convertActivityLevelToBeDisplayed(
                              controller.currentUserData!.activityLevel),
                      measurementSystem: controller.measurementSystem,
                      dashboard: true,
                      energyUnit: controller.energyUnit,
                    ),
                    const SizedBox(height: 40),
                    SecondaryInfo(
                      protein:
                          controller.currentUserData!.proteinInGrams.toInt(),
                      carbs: controller.currentUserData!.carbsInGrams.toInt(),
                      fat: controller.currentUserData!.fatInGrams.toInt(),
                      calories: controller.currentUserData!.calories.toInt(),
                      energyUnit: controller.energyUnit,
                      measurementSystem: controller.measurementSystem,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
