import 'package:calories_calculator/Controllers/auth_controller.dart';
import 'package:calories_calculator/Widgets/app_bar.dart';
import 'package:calories_calculator/Widgets/button.dart';
import 'package:calories_calculator/Widgets/dropdown.dart';
import 'package:calories_calculator/Widgets/settings_card.dart';
import 'package:calories_calculator/Widgets/text.dart';
import 'package:calories_calculator/Widgets/text_form_field.dart';
import 'package:calories_calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Measurements extends StatelessWidget {
  final AuthController controller = Get.find();

  Measurements({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (builder) => SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: 'take measurements'.tr,
            leadingExists: true,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: controller.takeMeasurementsFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          MyCard(
                            buttonColor:
                                (controller.measurementSystem == 'metric')
                                    ? const Color(0xFFE5FFEA)
                                    : Colors.white,
                            label: 'metric'.tr,
                            text: 'm, cm, kg'.tr,
                            textsColor:
                                (controller.measurementSystem == 'metric')
                                    ? MyColors().myGreen
                                    : Colors.black,
                            path: (controller.measurementSystem == 'metric')
                                ? 'assets/kiloGreen.png'
                                : 'assets/kiloBlackOutlined.png',
                            function: () {
                              controller.changeMeasurementSystem('m');
                            },
                          ),
                          const SizedBox(width: 20),
                          MyCard(
                            buttonColor:
                                (controller.measurementSystem == 'imperial')
                                    ? const Color(0xFFE5FFEA)
                                    : Colors.white,
                            label: 'imperial'.tr,
                            text: 'ft, inch, lb'.tr,
                            textsColor:
                                (controller.measurementSystem == 'imperial')
                                    ? MyColors().myGreen
                                    : Colors.black,
                            path: (controller.measurementSystem == 'imperial')
                                ? 'assets/poundGreen.png'
                                : 'assets/poundBlackOutlined.png',
                            function: () {
                              controller.changeMeasurementSystem('i');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyDropdown(
                            width: (Get.width - 60) / 2,
                            hintText: 'gender'.tr,
                            value: controller.gender,
                            items: (Get.locale?.languageCode == 'ar') ? controller.gendersArabic : controller.genders,
                            changeValue: controller.selectGender,
                            icon: Image.asset('assets/Genders.png'),
                            validatorFunction: controller.validateGender,
                          ),
                          MyField(
                            width: (Get.width - 60) / 2,
                            controller: controller.ageController,
                            hintText: 'age'.tr,
                            isPassword: false,
                            isLast: false,
                            isName: false,
                            type: TextInputType.number,
                            prefixIcon: const Icon(Icons.calendar_month_sharp),
                            suffixIcon: null,
                            suffixIconFunction: null,
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
                            controller: controller.heightController,
                            hintText: (controller.measurementSystem == 'metric')
                                ? 'height (cm)'.tr
                                : 'height (inch)'.tr,
                            isPassword: false,
                            isLast: false,
                            isName: false,
                            type: TextInputType.number,
                            prefixIcon: Image.asset('assets/Ruler.png'),
                            suffixIcon: null,
                            suffixIconFunction: null,
                            validatorFunction: controller.validateHeight,
                          ),
                          MyField(
                            width: (Get.width - 60) / 2,
                            controller: controller.weightController,
                            hintText: (controller.measurementSystem == 'metric')
                                ? 'weight (kg)'.tr
                                : 'weight (lb)'.tr,
                            isPassword: false,
                            isLast: false,
                            isName: false,
                            type: TextInputType.number,
                            prefixIcon: Image.asset(
                                (controller.measurementSystem == 'metric')
                                    ? 'assets/kiloBlack.png'
                                    : 'assets/poundBlack.png'),
                            suffixIcon: null,
                            suffixIconFunction: null,
                            validatorFunction: controller.validateWeight,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      MyDropdown(
                        width: Get.width,
                        hintText: 'activity level'.tr,
                        value: controller.activityLevel,
                        items: (Get.locale?.languageCode == 'ar') ? controller.activityLevelsArabic : controller.activityLevels,
                        changeValue: controller.selectActivityLevel,
                        icon: Image.asset('assets/Running.png'),
                        validatorFunction: controller.validateActivityLevel,
                      ),
                      const SizedBox(height: 20),
                      MyField(
                        width: 100.w,
                        controller: controller.proteinController,
                        hintText: 'protein percentage'.tr,
                        isPassword: false,
                        isLast: false,
                        isName: false,
                        type: TextInputType.number,
                        prefixIcon: Image.asset('assets/Biotech.png'),
                        suffixIcon: Image.asset('assets/PercentageRed.png'),
                        suffixIconFunction: null,
                        validatorFunction: controller.validateProtein,
                      ),
                      const SizedBox(height: 20),
                      MyField(
                        width: 100.w,
                        controller: controller.carbsController,
                        hintText: 'carbs percentage'.tr,
                        isPassword: false,
                        isLast: false,
                        isName: false,
                        type: TextInputType.number,
                        prefixIcon: Image.asset('assets/Barley.png'),
                        suffixIcon: Image.asset('assets/PercentageBlue.png'),
                        suffixIconFunction: null,
                        validatorFunction: controller.validateCarbs,
                      ),
                      const SizedBox(height: 20),
                      MyField(
                        width: 100.w,
                        controller: controller.fatController,
                        hintText: 'fat percentage'.tr,
                        isPassword: false,
                        isLast: true,
                        isName: false,
                        type: TextInputType.number,
                        prefixIcon: Image.asset('assets/Blur.png'),
                        suffixIcon: Image.asset('assets/PercentageBrown.png'),
                        suffixIconFunction: null,
                        validatorFunction: controller.validateFat,
                      ),
                      (controller.displayAddingError)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            )
                          : Container(),
                      const SizedBox(height: 40),
                      MyButton(
                        buttonFunction: () {
                          controller.validateTotal();
                          if (controller.takeMeasurementsFormKey.currentState!
                                  .validate() &&
                              controller.correctTotal) {
                            controller.register();
                          }
                        },
                        height: 40,
                        width: 100.w,
                        color: MyColors().myGreen,
                        disabled: controller.isLoading,
                        child: (controller.isLoading)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    text: 'registering'.tr,
                                    size: 16,
                                    weight: FontWeight.normal,
                                    color: Colors.white,
                                    align: TextAlign.left,
                                  ),
                                ],
                              )
                            : MyText(
                                text: 'register'.tr,
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
    );
  }
}
