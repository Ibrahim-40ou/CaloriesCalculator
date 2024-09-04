import 'package:calories_calculator/Widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../Controllers/home_controller.dart';
import '../../Widgets/button.dart';
import '../../Widgets/settings_card.dart';
import '../../Widgets/text.dart';
import '../../colors.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

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
              : SafeArea(
                  child: Scaffold(
                    appBar: MyAppBar(
                      title: 'settings'.tr,
                      leadingExists: false,
                    ),
                    backgroundColor: Colors.white,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                path:
                                    (controller.measurementSystem == 'imperial')
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
                            children: [
                              MyCard(
                                buttonColor: (controller.theme == 'light')
                                    ? const Color(0xFFE5FFEA)
                                    : Colors.white,
                                label: 'theme'.tr,
                                text: 'light'.tr,
                                textsColor: (controller.theme == 'light')
                                    ? MyColors().myGreen
                                    : Colors.black,
                                path: (controller.theme == 'light')
                                    ? 'assets/SunGreen.png'
                                    : 'assets/SunOutlined.png',
                                function: () {
                                  controller.changeTheme('l');
                                },
                              ),
                              const SizedBox(width: 20),
                              MyCard(
                                buttonColor: (controller.theme == 'dark')
                                    ? const Color(0xFFE5FFEA)
                                    : Colors.white,
                                label: 'theme'.tr,
                                text: 'dark'.tr,
                                textsColor: (controller.theme == 'dark')
                                    ? MyColors().myGreen
                                    : Colors.black,
                                path: (controller.theme == 'dark')
                                    ? 'assets/NightGreen.png'
                                    : 'assets/NightOutlined.png',
                                function: () {
                                  controller.changeTheme('d');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              MyCard(
                                buttonColor: (controller.language == 'en')
                                    ? const Color(0xFFE5FFEA)
                                    : Colors.white,
                                label: 'Language',
                                text: 'English',
                                textsColor: (controller.language == 'en')
                                    ? MyColors().myGreen
                                    : Colors.black,
                                path: (controller.language == 'en')
                                    ? 'assets/ArabicGreen.png'
                                    : 'assets/ArabicOutlined.png',
                                function: () {
                                  controller.changeLanguage('en');
                                },
                              ),
                              const SizedBox(width: 20),
                              MyCard(
                                buttonColor: (controller.language == 'ar')
                                    ? const Color(0xFFE5FFEA)
                                    : Colors.white,
                                label: 'اللغة',
                                text: 'العربية',
                                textsColor: (controller.language == 'ar')
                                    ? MyColors().myGreen
                                    : Colors.black,
                                path: (controller.language == 'ar')
                                    ? 'assets/ArabicGreen.png'
                                    : 'assets/ArabicOutlined.png',
                                function: () {
                                  controller.changeLanguage('ar');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              MyCard(
                                buttonColor:
                                    (controller.energyUnit == 'calories')
                                        ? const Color(0xFFE5FFEA)
                                        : Colors.white,
                                label: 'energy'.tr,
                                text: 'calories'.tr,
                                textsColor:
                                    (controller.energyUnit == 'calories')
                                        ? MyColors().myGreen
                                        : Colors.black,
                                path: (controller.energyUnit == 'calories')
                                    ? 'assets/FireGreen.png'
                                    : 'assets/FireOutlined.png',
                                function: () {
                                  controller.changeEnergyUnits('cal');
                                },
                              ),
                              const SizedBox(width: 20),
                              MyCard(
                                buttonColor: (controller.energyUnit == 'joules')
                                    ? const Color(0xFFE5FFEA)
                                    : Colors.white,
                                label: 'energy'.tr,
                                text: 'joules'.tr,
                                textsColor: (controller.energyUnit == 'joules')
                                    ? MyColors().myGreen
                                    : Colors.black,
                                path: (controller.energyUnit == 'joules')
                                    ? 'assets/FireGreen.png'
                                    : 'assets/FireOutlined.png',
                                function: () {
                                  controller.changeEnergyUnits('jou');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          MyButton(
                            buttonFunction: () {
                              controller.showDialogue(
                                false,
                                '',
                                controller.logOut,
                                'are you sure you want to sign out of your account?'
                                    .tr,
                              );
                            },
                            height: 40,
                            width: 100.w,
                            color: MyColors().myGreen,
                            disabled: controller.isLoading,
                            child: (controller.isLoading)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        text: 'signing out'.tr,
                                        size: 16,
                                        weight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                : MyText(
                                    text: 'sign out'.tr,
                                    size: 16,
                                    weight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
