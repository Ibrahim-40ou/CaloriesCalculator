import 'package:calories_calculator/View/App/view_measurement.dart';
import 'package:calories_calculator/Widgets/app_bar.dart';
import 'package:calories_calculator/Widgets/settings_card.dart';
import 'package:calories_calculator/Widgets/text.dart';
import 'package:calories_calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/home_controller.dart';
import '../../Widgets/button.dart';

class Measure extends StatelessWidget {
  const Measure({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: 'measure'.tr,
            leadingExists: controller.listEditingMode,
            leadingFunction: () {
              controller.showDialogue(
                false,
                '',
                controller.cancelListEditing,
                'all selections will be lost. are you sure you want to cancel editing?'
                    .tr,
              );
            },
            actionExists: controller.userMeasurements.isEmpty ? false : true,
            icon: controller.listEditingMode
                ? Icon(
                    Icons.delete,
                    color: MyColors().myRed,
                  )
                : const Icon(Icons.edit),
            actionFunction: () {
              if (controller.listEditingMode) {
                controller.showDialogue(
                  false,
                  '',
                  controller.deleteItems,
                  'selected measurements will be deleted. are you sure you want to continue?'
                      .tr,
                );
              } else {
                controller.changeEditingMode(true);
              }
            },
          ),
          backgroundColor: Colors.white,
          body: controller.fetchingMeasurements
              ? Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: MyColors().myBlue,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : (!controller.fetchedUserData)
                  ? Row(
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
                    )
                  : controller.userMeasurements.isEmpty
                      ? Center(
                          child: MyText(
                            text: "there aren't any measurements.".tr,
                            size: 16,
                            weight: FontWeight.normal,
                            color: Colors.black,
                            align: TextAlign.center,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 100.h,
                            width: 100.w - 40,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 20,
                              ),
                              itemCount: controller.userMeasurements.length,
                              itemBuilder: (context, index) => MyCard(
                                buttonColor: (controller.toBeDeleted.contains(
                                        controller.userMeasurements[index]
                                            .measurementId!))
                                    ? MyColors().myGreen
                                    : Colors.white,
                                label:
                                    controller.userMeasurements[index].fullName,
                                text: controller.userMeasurements[index].date,
                                subText: controller.measurementSystem ==
                                        'metric'
                                    ? '${controller.userMeasurements[index].weight.toInt().toString()} ${'kg'.tr}'
                                    : '${(controller.userMeasurements[index].weight * 2.20462).toInt()}${'lb'.tr}',
                                trailingText: controller.energyUnit ==
                                        'calories'
                                    ? controller
                                        .userMeasurements[index].calories
                                        .toInt()
                                        .toString()
                                    : '${(controller.userMeasurements[index].calories * 4.184).toInt()}',
                                textsColor: (controller.toBeDeleted.contains(
                                        controller.userMeasurements[index]
                                            .measurementId!))
                                    ? Colors.white
                                    : Colors.black,
                                function: () {
                                  if (controller.listEditingMode) {
                                    controller.selectListElement(controller
                                        .userMeasurements[index]
                                        .measurementId!);
                                    return;
                                  }
                                  Get.to(
                                    () => ViewMeasurement(
                                      measurement:
                                          controller.userMeasurements[index],
                                    ),
                                  );
                                },
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 20),
                            ),
                          ),
                        ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/take_a_measurement');
            },
            backgroundColor: MyColors().myGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
