import 'package:calories_calculator/Models/user.dart';
import 'package:calories_calculator/Widgets/text.dart';
import 'package:calories_calculator/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../colors.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgotPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  void onLeaveLogin() {
    emailController.clear();
    passwordController.clear();
    loginFormKey.currentState?.reset();
    update();
  }

  void onLeavePasswordReset() {
    forgotPasswordController.clear();
    resetPasswordFormKey.currentState?.reset();
    update();
  }

  void onLeaveRegister() {
    fullNameController.clear();
    newEmailController.clear();
    newPasswordController.clear();
    ageController.clear();
    heightController.clear();
    weightController.clear();
    proteinController.clear();
    carbsController.clear();
    fatController.clear();
    gender = '';
    activityLevel = '';
    createProfileFormKey.currentState?.reset();
    takeMeasurementsFormKey.currentState?.reset();
    update();
  }

  static Widget _buildTextWidget(String text) {
    return MyText(
      text: text.tr,
      size: 16,
      weight: FontWeight.normal,
      color: Colors.black,
      overflow: TextOverflow.fade,
    );
  }

  String? gender;
  List<DropdownMenuItem<String>> get genders => [
        DropdownMenuItem(
          value: 'male',
          child: _buildTextWidget('male'),
        ),
        DropdownMenuItem(
          value: 'female',
          child: _buildTextWidget('female'),
        ),
      ];
  void selectGender(String? selectedGender) {
    gender = selectedGender;
    update();
  }

  List<DropdownMenuItem<String>> get gendersArabic {
    return [
      DropdownMenuItem(
        value: 'male',
        child: _buildTextWidget('ذكر'),
      ),
      DropdownMenuItem(
        value: 'female',
        child: _buildTextWidget('انثى'),
      ),
    ];
  }

  String? activityLevel;
  List<DropdownMenuItem<String>> get activityLevels => [
        DropdownMenuItem(
          value: 'bmr',
          child: _buildTextWidget('basal metabolic rate (bmr)'),
        ),
        DropdownMenuItem(
          value: 'sedentary',
          child: _buildTextWidget('sedentary: little or no exercise'),
        ),
        DropdownMenuItem(
          value: 'light',
          child: _buildTextWidget('light: exercise 1-3 times a weak'),
        ),
        DropdownMenuItem(
          value: 'moderate',
          child: _buildTextWidget('moderate: exercise 4-5 times a weak'),
        ),
        DropdownMenuItem(
          value: 'very',
          child: _buildTextWidget('very active: exercise 6-7 times a weak'),
        ),
        DropdownMenuItem(
          value: 'super',
          child: _buildTextWidget(
              'super active: daily exercise twice and a physical job'),
        ),
      ];

  List<DropdownMenuItem<String>> get activityLevelsArabic {
    return [
      DropdownMenuItem(
        value: 'bmr',
        child: _buildTextWidget('المعدل الايضي الاساسي'),
      ),
      DropdownMenuItem(
        value: 'sedentary',
        child: _buildTextWidget('ساكن: القليل من او انعدام التمرين'),
      ),
      DropdownMenuItem(
        value: 'light',
        child: _buildTextWidget('خفيف الحركة: التمرين ١-٣ مرات في الاسبوع'),
      ),
      DropdownMenuItem(
        value: 'moderate',
        child: _buildTextWidget('معتدل الحركة: التمرين ٤-٥ مرات في الاسبوع'),
      ),
      DropdownMenuItem(
        value: 'very',
        child: _buildTextWidget('نشيط: التمرين ٦-٧ مرات في الاسبوع'),
      ),
      DropdownMenuItem(
        value: 'super',
        child: _buildTextWidget('نشيط جدا: التمرين الي ومي مرتين وعمل بدني'),
      ),
    ];
  }

  void selectActivityLevel(String? selectedActivityLevel) {
    activityLevel = selectedActivityLevel;
    update();
  }

  bool showPasswordLogin = true;
  void showPasswordFunctionLogin() {
    showPasswordLogin = !showPasswordLogin;
    update();
  }

  bool showPasswordRegister = true;
  void showPasswordFunctionRegister() {
    showPasswordRegister = !showPasswordRegister;
    update();
  }

  String measurementSystem = 'metric';
  void changeMeasurementSystem(String key) {
    measurementSystem = (key == 'm') ? 'metric' : 'imperial';
    update();
  }

  final resetPasswordFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  String? validateEmail(String? email) =>
      EmailValidator.validate(email!.trim()) ? null : 'enter a valid email.'.tr;

  String? validatePassword(String? password) => (password!.length > 5)
      ? null
      : 'password must be more than 6 characters.'.tr;

  final createProfileFormKey = GlobalKey<FormState>();
  String? validateName(String? name) =>
      (name!.isEmpty) ? 'enter a valid full name.'.tr : null;
  final takeMeasurementsFormKey = GlobalKey<FormState>();
  String? validateGender(String? gender) =>
      (gender == null || gender.isEmpty) ? 'enter a valid gender.'.tr : null;

  String? validateAge(String? age) {
    if (age == null || age.isEmpty) return 'enter a valid age.'.tr;
    double parsedAge = double.parse(age);
    if (parsedAge <= 0 || parsedAge > 122) return 'enter a valid age.'.tr;
    return null;
  }

  String? validateHeight(String? height) {
    if (height == null || height.isEmpty) return 'enter a valid height.'.tr;
    double parsedHeight = double.parse(height);
    if (measurementSystem == 'metric') {
      if (parsedHeight > 272 || parsedHeight <= 0)
        return 'enter a valid height.'.tr;
    } else {
      if (parsedHeight > 107 || parsedHeight <= 0)
        return 'enter a valid height.'.tr;
    }
    return null;
  }

  String? validateWeight(String? weight) {
    if (weight == null || weight.isEmpty) return 'enter a valid weight.'.tr;
    if (double.parse(weight) <= 0) return 'enter a valid weight.'.tr;
    return null;
  }

  String? validateActivityLevel(String? activityLevel) =>
      (activityLevel == null || activityLevel.isEmpty)
          ? 'enter a valid activity level.'.tr
          : null;

  String? validateProtein(String? protein) =>
      (protein!.isEmpty) ? 'enter a valid protein percentage.'.tr : null;

  String? validateCarbs(String? carbs) =>
      (carbs!.isEmpty) ? 'enter a valid carbs percentage.'.tr : null;

  String? validateFat(String? fat) =>
      (fat!.isEmpty) ? 'enter a valid fat percentage.'.tr : null;

  bool correctTotal = false;
  bool displayAddingError = false;
  void validateTotal() {
    if (proteinController.text.isEmpty ||
        carbsController.text.isEmpty ||
        fatController.text.isEmpty) return;
    double total = double.parse(proteinController.text) +
        double.parse(carbsController.text) +
        double.parse(fatController.text);
    if (total != 100) {
      correctTotal = false;
      displayAddingError = true;
    } else {
      correctTotal = true;
      displayAddingError = false;
    }
    update();
  }

  bool loginError = false;
  bool registerError = false;
  bool passwordResetError = false;
  String errorText = '';
  void exitDialogue() {
    loginError = false;
    registerError = false;
    passwordResetError = false;
    errorText = '';
    update();
  }

  String handleError(String exception) {
    switch (exception) {
      case 'invalid-credential':
        return 'email or password entered do not correspond to any account. please check your information.'
            .tr;
      case 'email-already-in-use':
        return 'the email address you entered is already in use by a different account.'
            .tr;
      case 'network-request-failed':
        return 'network error. please try again later.'.tr;
      case 'too-many-requests':
        return 'too many requests. please wait before trying again.'.tr;
      case 'user-not-found':
        return 'no account is associated with the entered email address.'.tr;
      default:
        return exception;
    }
  }

  void showDialogue(bool isError, String errorText, Function? leave) {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async {
          exitDialogue();
          return true;
        },
        child: Center(
          child: Container(
            height: 164,
            width: Get.width - 40,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: (isError) ? 'error occurred'.tr : 'confirmation'.tr,
                  size: 16,
                  weight: FontWeight.normal,
                  color: MyColors().myRed,
                  overflow: TextOverflow.visible,
                  decoration: TextDecoration.none,
                ),
                const SizedBox(height: 16),
                MyText(
                  text: (isError)
                      ? errorText
                      : 'all the information you entered will be lost. are you sure you want to exit?'
                          .tr,
                  size: 14,
                  weight: FontWeight.normal,
                  color: Colors.black,
                  overflow: TextOverflow.visible,
                  decoration: TextDecoration.none,
                ),
                const SizedBox(height: 24),
                (isError)
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            exitDialogue();
                            Get.back();
                          },
                          child: MyText(
                            text: 'okay'.tr,
                            size: 14,
                            weight: FontWeight.normal,
                            color: MyColors().myBlue,
                            overflow: TextOverflow.visible,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              exitDialogue();
                              Get.back();
                            },
                            child: MyText(
                              text: 'cancel'.tr,
                              size: 14,
                              weight: FontWeight.normal,
                              color: MyColors().myRed,
                              overflow: TextOverflow.visible,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              exitDialogue();
                              if (leave != null) {
                                leave();
                              }
                              Get.back();
                              Get.back();
                            },
                            child: MyText(
                              text: 'okay'.tr,
                              size: 14,
                              weight: FontWeight.normal,
                              color: MyColors().myBlue,
                              overflow: TextOverflow.visible,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  void activateLoading() {
    isLoading = true;
    update();
  }

  void disableLoading() {
    isLoading = false;
    update();
  }

  CollectionReference usersInstance =
      FirebaseFirestore.instance.collection('users');
  double bmr = 0;
  double calories = 0;
  double proteinInGrams = 0;
  double carbsInGrams = 0;
  double fatInGrams = 0;
  Future calculateDietaryMetrics(
    double height,
    double weight,
    double age,
    double protein,
    double carbs,
    double fat,
    String gender,
    String activityLevel,
    String measurementSystem,
  ) async {
    try {
      if (measurementSystem == 'imperial') {
        height *= 2.54;
        weight *= 0.453592;
      }
      bmr = 10 * weight + 6.25 * height - 5 * age;
      gender == 'male' ? bmr += 5 : bmr -= 161;
      switch (activityLevel) {
        case 'bmr':
          calories = bmr;
        case 'sedentary':
          calories = bmr * 1.2;
        case 'light':
          calories = bmr * 1.375;
        case 'moderate':
          calories = bmr * 1.55;
        case 'very':
          calories = bmr * 1.725;
        case 'super':
          calories = bmr * 1.9;
      }
      double onePercent = (calories > 0) ? calories / 100 : bmr / 100;
      proteinInGrams = onePercent * protein / 4;
      carbsInGrams = onePercent * carbs / 4;
      fatInGrams = onePercent * fat / 9;
      update();
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  void register() async {
    try {
      activateLoading();
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newEmailController.text.trim(),
        password: newPasswordController.text,
      );
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc('${userCredential.user?.uid}');
      calculateDietaryMetrics(
        double.parse(heightController.text),
        double.parse(weightController.text),
        double.parse(ageController.text),
        double.parse(proteinController.text),
        double.parse(carbsController.text),
        double.parse(fatController.text),
        gender!,
        activityLevel!,
        measurementSystem,
      );
      await docRef.set(MyUser(
        userId: userCredential.user?.uid,
        fullName: fullNameController.text,
        email: newEmailController.text,
        measurementSystem: measurementSystem,
        gender: gender!,
        age: double.parse(ageController.text),
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        activityLevel: activityLevel!,
        proteinPercentage: double.parse(proteinController.text),
        carbsPercentage: double.parse(carbsController.text),
        fatPercentage: double.parse(fatController.text),
        bmr: bmr,
        calories: calories,
        proteinInGrams: proteinInGrams,
        carbsInGrams: carbsInGrams,
        fatInGrams: fatInGrams,
      ).toJson());
      disableLoading();
      loginCheck!.setString('loggedIn', 'true');
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      registerError = true;
      disableLoading();
      errorText = handleError(e.code);
    }
    update();
  }

  void logIn() async {
    try {
      activateLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      disableLoading();
      loginCheck!.setString('loggedIn', 'true');
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      loginError = true;
      disableLoading();
      errorText = handleError(e.code);
    }
    update();
  }

  bool googleSignIn = false;
  Future signInWithGoogle() async {}

  void resetPassword() async {
    try {
      activateLoading();
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgotPasswordController.text.trim(),
      );
      disableLoading();
    } on FirebaseAuthException catch (e) {
      passwordResetError = true;
      disableLoading();
      errorText = handleError(e.code);
    }
    update();
  }
}
