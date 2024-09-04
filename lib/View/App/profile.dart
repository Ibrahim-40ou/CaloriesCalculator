import 'package:calories_calculator/Widgets/app_bar.dart';
import 'package:calories_calculator/Widgets/button.dart';
import 'package:calories_calculator/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/home_controller.dart';
import '../../Widgets/dropdown.dart';
import '../../Widgets/text.dart';
import '../../colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => (controller.fetchingUserData)
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
          : ((!controller.fetchedUserData) && controller.completedCalculations)
              ? Center(
                  child: MyText(
                    text: 'error fetching user data.'.tr,
                    size: 16,
                    weight: FontWeight.normal,
                    color: Colors.black,
                    align: TextAlign.center,
                  ),
                )
              : WillPopScope(
                  onWillPop: () async {
                    if (controller.editingInfo) {
                      controller.showDialogue(
                        false,
                        '',
                        controller.cancelEdit,
                        'all the information you edited will be lost. are you sure you want to exit?'
                            .tr,
                      );
                    }
                    return true;
                  },
                  child: SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: MyAppBar(
                        title: 'profile'.tr,
                        leadingExists: true,
                        leadingFunction: () {
                          if (controller.editingInfo) {
                            controller.showDialogue(
                              false,
                              '',
                              controller.cancelEdit,
                              'all the information you edited will be lost. are you sure you want to exit?'
                                  .tr,
                            );
                            return;
                          }
                          Get.back();
                        },
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Form(
                              key: controller.profileFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  MyField(
                                    width: 100.w,
                                    controller: controller.fullNameController,
                                    hintText: 'full name'.tr,
                                    isPassword: false,
                                    isLast: false,
                                    isName: true,
                                    type: TextInputType.text,
                                    prefixIcon:
                                        const Icon(Icons.account_circle),
                                    suffixIcon: null,
                                    suffixIconFunction: null,
                                    enabled: controller.editingInfo,
                                    validatorFunction: controller.validateName,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyDropdown(
                                        width: (Get.width - 60) / 2,
                                        hintText: 'gender'.tr,
                                        value:
                                            controller.currentUserData!.gender,
                                        items:
                                            (Get.locale?.languageCode == 'ar')
                                                ? controller.gendersArabic
                                                : controller.genders,
                                        changeValue: controller.selectGender,
                                        icon: Image.asset('assets/Genders.png'),
                                        validatorFunction:
                                            controller.validateGender,
                                        enabled: controller.editingInfo,
                                      ),
                                      MyField(
                                        width: (Get.width - 60) / 2,
                                        controller: controller.ageController,
                                        hintText: 'age'.tr,
                                        isPassword: false,
                                        isLast: false,
                                        isName: false,
                                        type: TextInputType.number,
                                        prefixIcon: const Icon(
                                            Icons.calendar_month_sharp),
                                        suffixIcon: null,
                                        suffixIconFunction: null,
                                        validatorFunction:
                                            controller.validateAge,
                                        enabled: controller.editingInfo,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyField(
                                        width: (Get.width - 60) / 2,
                                        controller: controller.heightController,
                                        hintText:
                                            (controller.measurementSystem ==
                                                    'metric')
                                                ? 'height (cm)'.tr
                                                : 'height (inch)'.tr,
                                        isPassword: false,
                                        isLast: false,
                                        isName: false,
                                        type: TextInputType.number,
                                        prefixIcon:
                                            Image.asset('assets/Ruler.png'),
                                        suffixIcon: null,
                                        suffixIconFunction: null,
                                        validatorFunction:
                                            controller.validateHeight,
                                        enabled: controller.editingInfo,
                                      ),
                                      MyField(
                                        width: (Get.width - 60) / 2,
                                        controller: controller.weightController,
                                        hintText:
                                            (controller.measurementSystem ==
                                                    'metric')
                                                ? 'weight (kg)'.tr
                                                : 'weight (lb)'.tr,
                                        isPassword: false,
                                        isLast: false,
                                        isName: false,
                                        type: TextInputType.number,
                                        prefixIcon: Image.asset(
                                            (controller.measurementSystem ==
                                                    'metric')
                                                ? 'assets/kiloBlack.png'
                                                : 'assets/poundBlack.png'),
                                        suffixIcon: null,
                                        suffixIconFunction: null,
                                        validatorFunction:
                                            controller.validateWeight,
                                        enabled: controller.editingInfo,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  MyDropdown(
                                    width: Get.width,
                                    hintText: 'activity level'.tr,
                                    value: controller
                                        .currentUserData!.activityLevel,
                                    items: (Get.locale?.languageCode == 'ar')
                                        ? controller.activityLevelsArabic
                                        : controller.activityLevels,
                                    changeValue: controller.selectActivityLevel,
                                    icon: Image.asset('assets/Running.png'),
                                    validatorFunction:
                                        controller.validateActivityLevel,
                                    enabled: controller.editingInfo,
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
                                    prefixIcon:
                                        Image.asset('assets/Biotech.png'),
                                    suffixIcon:
                                        Image.asset('assets/PercentageRed.png'),
                                    suffixIconFunction: null,
                                    validatorFunction:
                                        controller.validateProtein,
                                    enabled: controller.editingInfo,
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
                                    prefixIcon:
                                        Image.asset('assets/Barley.png'),
                                    suffixIcon: Image.asset(
                                        'assets/PercentageBlue.png'),
                                    suffixIconFunction: null,
                                    validatorFunction: controller.validateCarbs,
                                    enabled: controller.editingInfo,
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
                                    suffixIcon: Image.asset(
                                        'assets/PercentageBrown.png'),
                                    suffixIconFunction: null,
                                    validatorFunction: controller.validateFat,
                                    enabled: controller.editingInfo,
                                  ),
                                  (controller.displayAddingError)
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                  (controller.editingInfo)
                                      ? Column(
                                          children: [
                                            MyButton(
                                              buttonFunction: () {
                                                controller.validateTotal(
                                                  controller
                                                      .proteinController.text,
                                                  controller
                                                      .carbsController.text,
                                                  controller.fatController.text,
                                                );
                                                if (controller.profileFormKey
                                                        .currentState!
                                                        .validate() &&
                                                    controller.correctTotal) {
                                                  controller.finishEdit();
                                                }
                                              },
                                              height: 40,
                                              width: 100.w,
                                              color: MyColors().myGreen,
                                              child: MyText(
                                                text: 'save changes'.tr,
                                                size: 16,
                                                weight: FontWeight.normal,
                                                color: Colors.white,
                                                align: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            MyButton(
                                              buttonFunction: () {
                                                controller.cancelPressedFunc();
                                                controller.showDialogue(
                                                  false,
                                                  '',
                                                  controller.cancelEdit,
                                                  'all the information you edited will be lost. are you sure you want to cancel editing?'
                                                      .tr,
                                                );
                                              },
                                              height: 40,
                                              width: 100.w,
                                              color: MyColors().myRed,
                                              child: MyText(
                                                text: 'cancel'.tr,
                                                size: 16,
                                                weight: FontWeight.normal,
                                                color: Colors.white,
                                                align: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        )
                                      : MyButton(
                                          buttonFunction: controller.edit,
                                          height: 40,
                                          width: 100.w,
                                          color: MyColors().myGreen,
                                          child: MyText(
                                            text: 'edit information'.tr,
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
