import 'package:calories_calculator/View/App/view_measurement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:calories_calculator/Controllers/home_controller.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/dropdown.dart';
import '../../Widgets/text.dart';
import '../../Widgets/text_form_field.dart';
import '../../colors.dart';

class TakeAMeasurement extends StatelessWidget {
  const TakeAMeasurement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: 'take a measurement'.tr,
            leadingExists: true,
            leadingFunction: () {
              controller.showDialogue(
                  false,
                  '',
                  controller.onLeaveTakeAMeasurement,
                  'all the information you entered will be lost. are you sure you want to exit?'
                      .tr);
            },
          ),
          backgroundColor: Colors.white,
          body: WillPopScope(
            onWillPop: () async {
              controller.showDialogue(
                  false,
                  '',
                  controller.onLeaveTakeAMeasurement,
                  'all the information you entered will be lost. are you sure you want to exit?'
                      .tr);
              return true;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.takeAMeasurementFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        MyField(
                          width: 100.w,
                          controller: controller.measureFullNameController,
                          hintText: 'full name'.tr,
                          isPassword: false,
                          isLast: false,
                          isName: true,
                          type: TextInputType.text,
                          prefixIcon: const Icon(
                            Icons.account_circle,
                            size: 24,
                            color: Colors.black,
                          ),
                          validatorFunction: controller.validateName,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyDropdown(
                              width: (Get.width - 60) / 2,
                              hintText: 'gender'.tr,
                              value: controller.measureGender,
                              items: (Get.locale?.languageCode == 'ar')
                                  ? controller.gendersArabic
                                  : controller.genders,
                              changeValue: controller.selectMeasurementGender,
                              icon: Image.asset('assets/Genders.png'),
                              validatorFunction: controller.validateGender,
                            ),
                            MyField(
                              width: (Get.width - 60) / 2,
                              controller: controller.measureAgeController,
                              hintText: 'age'.tr,
                              isPassword: false,
                              isLast: false,
                              isName: false,
                              type: TextInputType.number,
                              prefixIcon:
                                  const Icon(Icons.calendar_month_sharp),
                              validatorFunction: controller.validateAge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyField(
                              width: (Get.width - 60) / 2,
                              controller: controller.measureHeightController,
                              hintText:
                                  (controller.measurementSystem == 'metric')
                                      ? 'height (cm)'.tr
                                      : 'height (inch)'.tr,
                              isPassword: false,
                              isLast: false,
                              isName: false,
                              type: TextInputType.number,
                              prefixIcon: Image.asset('assets/Ruler.png'),
                              validatorFunction: controller.validateHeight,
                            ),
                            MyField(
                              width: (Get.width - 60) / 2,
                              controller: controller.measureWeightController,
                              hintText:
                                  (controller.measurementSystem == 'metric')
                                      ? 'weight (kg)'.tr
                                      : 'weight (lb)'.tr,
                              isPassword: false,
                              isLast: false,
                              isName: false,
                              type: TextInputType.number,
                              prefixIcon: Image.asset(
                                (controller.measurementSystem == 'metric')
                                    ? 'assets/kiloBlack.png'
                                    : 'assets/poundBlack.png',
                              ),
                              validatorFunction: controller.validateWeight,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        MyDropdown(
                          width: Get.width,
                          hintText: 'activity level'.tr,
                          value: controller.measureActivityLevel,
                          items: (Get.locale?.languageCode == 'ar')
                              ? controller.activityLevelsArabic
                              : controller.activityLevels,
                          changeValue:
                              controller.selectMeasurementActivityLevel,
                          icon: Image.asset('assets/Running.png'),
                          validatorFunction: controller.validateActivityLevel,
                        ),
                        const SizedBox(height: 20),
                        MyField(
                          width: 100.w,
                          controller: controller.measureProteinController,
                          hintText: 'protein percentage'.tr,
                          isPassword: false,
                          isLast: false,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: Image.asset('assets/Biotech.png'),
                          suffixIcon: Image.asset('assets/PercentageRed.png'),
                          validatorFunction: controller.validateProtein,
                        ),
                        const SizedBox(height: 20),
                        MyField(
                          width: 100.w,
                          controller: controller.measureCarbsController,
                          hintText: 'carbs percentage'.tr,
                          isPassword: false,
                          isLast: false,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: Image.asset('assets/Barley.png'),
                          suffixIcon: Image.asset('assets/PercentageBlue.png'),
                          validatorFunction: controller.validateCarbs,
                        ),
                        const SizedBox(height: 20),
                        MyField(
                          width: 100.w,
                          controller: controller.measureFatController,
                          hintText: 'fat percentage'.tr,
                          isPassword: false,
                          isLast: true,
                          isName: false,
                          type: TextInputType.number,
                          prefixIcon: Image.asset('assets/Blur.png'),
                          suffixIcon: Image.asset('assets/PercentageBrown.png'),
                          validatorFunction: controller.validateFat,
                        ),
                        if (controller.displayAddingError)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              MyText(
                                text:
                                    'please enter macro values that add up to 100%.'
                                        .tr,
                                size: 14,
                                weight: FontWeight.normal,
                                color: MyColors().myRed,
                                align: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        const SizedBox(height: 40),
                        MyButton(
                          buttonFunction: () async {
                            controller.validateTotal(
                              controller.measureProteinController.text,
                              controller.measureCarbsController.text,
                              controller.measureFatController.text,
                            );
                            if (controller.takeAMeasurementFormKey.currentState!
                                    .validate() &&
                                controller.correctTotal) {
                              controller.activateLoading();
                              await controller.takeAMeasurement();
                              controller.correctTotal = false;
                              controller.disableLoading();
                              controller.onLeaveTakeAMeasurement();
                              Get.to(
                                () => ViewMeasurement(
                                  measurement: controller.userMeasurements.last,
                                ),
                              );
                            }
                          },
                          height: 40,
                          width: 100.w,
                          color: MyColors().myGreen,
                          disabled: controller.isLoading,
                          child: controller.isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    MyText(
                                      text: 'calculating'.tr,
                                      size: 16,
                                      weight: FontWeight.normal,
                                      color: Colors.white,
                                      align: TextAlign.left,
                                    ),
                                  ],
                                )
                              : MyText(
                                  text: 'calculate'.tr,
                                  size: 16,
                                  weight: FontWeight.normal,
                                  color: Colors.white,
                                  align: TextAlign.center,
                                ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
