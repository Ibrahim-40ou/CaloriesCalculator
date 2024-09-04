import 'package:calories_calculator/Models/measurement.dart';
import 'package:calories_calculator/View/App/dashboard.dart';
import 'package:calories_calculator/View/App/measure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user.dart';
import '../View/App/app_settings.dart';
import '../Widgets/text.dart';
import '../colors.dart';
import '../main.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  bool fetchingUserData = true;
  bool fetchingMeasurements = true;
  @override
  void onInit() async {
    super.onInit();
    await loadPreferences();
    await getUserData();
    fetchingUserData = false;
    await fetchMeasurements();
    fetchingMeasurements = false;
    update();
  }

  void onLeaveTakeAMeasurement() {
    takeAMeasurementFormKey.currentState!.reset();
    measureFullNameController.clear();
    measureAgeController.clear();
    measureHeightController.clear();
    measureWeightController.clear();
    measureProteinController.clear();
    measureCarbsController.clear();
    measureFatController.clear();
    measureGender = null;
    measureActivityLevel = null;
    update();
    Get.back();
  }

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  final TextEditingController measureFullNameController =
      TextEditingController();
  final TextEditingController measureAgeController = TextEditingController();
  final TextEditingController measureHeightController = TextEditingController();
  final TextEditingController measureWeightController = TextEditingController();
  final TextEditingController measureProteinController =
      TextEditingController();
  final TextEditingController measureCarbsController = TextEditingController();
  final TextEditingController measureFatController = TextEditingController();
  String? measureGender;
  String? measureActivityLevel;

  static Widget _buildTextWidget(String text) {
    return MyText(
      text: text,
      size: 16,
      weight: FontWeight.normal,
      color: Colors.black,
      overflow: TextOverflow.fade,
    );
  }

  List<DropdownMenuItem<String>> get genders {
    return [
      DropdownMenuItem(
        value: 'male',
        child: _buildTextWidget('Male'),
      ),
      DropdownMenuItem(
        value: 'female',
        child: _buildTextWidget('Female'),
      ),
    ];
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

  String? gender;
  void selectGender(String? selectedGender) {
    gender = selectedGender;
    update();
  }

  List<DropdownMenuItem<String>> get activityLevels {
    return [
      DropdownMenuItem(
        value: 'bmr',
        child: _buildTextWidget('Basal Metabolic Rate (BMR)'),
      ),
      DropdownMenuItem(
        value: 'sedentary',
        child: _buildTextWidget('Sedentary: Little or no Exercise'),
      ),
      DropdownMenuItem(
        value: 'light',
        child: _buildTextWidget('Light: Exercise 1-3 Times a Weak'),
      ),
      DropdownMenuItem(
        value: 'moderate',
        child: _buildTextWidget('Moderate: Exercise 4-5 Times a Weak'),
      ),
      DropdownMenuItem(
        value: 'very',
        child: _buildTextWidget('Very Active: Exercise 6-7 Times a Weak'),
      ),
      DropdownMenuItem(
        value: 'super',
        child: _buildTextWidget(
            'Super Active: Daily Exercise Twice and a Physical Job'),
      ),
    ];
  }

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

  String? activityLevel;
  void selectActivityLevel(String? selectedActivityLevel) {
    activityLevel = selectedActivityLevel;
    update();
  }

  final profileFormKey = GlobalKey<FormState>();

  String? validateName(String? name) =>
      (name!.isEmpty) ? 'enter a valid full name.'.tr : null;
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
          ? 'enter a valid activity level.'
          : null;

  String? validateProtein(String? protein) =>
      (protein!.isEmpty) ? 'enter a valid protein percentage.'.tr : null;

  String? validateCarbs(String? carbs) =>
      (carbs!.isEmpty) ? 'enter a valid carbs percentage.'.tr : null;

  String? validateFat(String? fat) =>
      (fat!.isEmpty) ? 'enter a valid fat percentage.'.tr : null;

  bool correctTotal = false;
  bool displayAddingError = false;

  void validateTotal(String protein, String carbs, String fat) {
    if (protein.isEmpty || carbs.isEmpty || fat.isEmpty) return;
    double total =
        double.parse(protein) + double.parse(carbs) + double.parse(fat);
    if (total != 100) {
      correctTotal = false;
      displayAddingError = true;
    } else {
      correctTotal = true;
      displayAddingError = false;
    }
    update();
  }

  PageController pageController = PageController();

  int currentIndex = 0;
  void changePage(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
    update();
  }

  List<BottomNavigationBarItem> navigationBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: 'home'.tr,
    ),
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.heart),
      activeIcon: const Icon(CupertinoIcons.heart_fill),
      label: 'measure'.tr,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings_outlined),
      activeIcon: const Icon(Icons.settings),
      label: 'settings'.tr,
    ),
  ];

  List<Widget> pageViewItems = [
    const Dashboard(),
    const Measure(),
    const AppSettings(),
  ];

  late String measurementSystem = currentUserData!.measurementSystem;
  void changeMeasurementSystem(String key) {
    measurementSystem = (key == 'm') ? 'metric' : 'imperial';
    currentUserData!.measurementSystem = measurementSystem;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserData!.userId)
        .update(
      {
        'measurementSystem': measurementSystem,
      },
    );
    update();
  }

  String theme = 'light';
  void changeTheme(String key) {
    theme = (key == 'l') ? 'light' : 'dark';
    update();
  }

  String language = '';
  void changeLanguage(String languageCode) async {
    Locale locale = Locale(languageCode);
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
    language = languageCode;
    update();
  }

  String energyUnit = 'calories';
  void changeEnergyUnits(String key) async {
    final prefs = await SharedPreferences.getInstance();
    energyUnit = (key == 'cal') ? 'calories' : 'joules';
    await prefs.setString('energyUnit', energyUnit);
    update();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    energyUnit = prefs.getString('energyUnit') ?? 'calories';
    language = prefs.getString('languageCode') ?? 'en';
    update();
  }

  MyUser? currentUserData;
  bool fetchedUserData = false;
  Future getUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        currentUserData = MyUser.fromJson(data);
        fetchedUserData = true;
        update();
        return;
      }
      fetchedUserData = false;
      update();
    } catch (e) {
      fetchedUserData = false;
      update();
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  String convertActivityLevelToBeDisplayed(String activityLevel) {
    switch (activityLevel) {
      case ('bmr'):
        return 'basal metabolic rate (bmr)'.tr;
      case ('sedentary'):
        return 'sedentary: little or no exercise'.tr;
      case ('light'):
        return 'light: exercise 1-3 times a weak'.tr;
      case ('moderate'):
        return 'moderate: exercise 4-5 times a weak'.tr;
      case ('very'):
        return 'very active: exercise 6-7 times a weak'.tr;
      case ('super'):
        return 'daily exercise twice and a physical job'.tr;
      default:
        return '';
    }
  }

  MyUser? preEditUserData;
  bool editingInfo = false;
  void edit() {
    editingInfo = true;
    preEditUserData = currentUserData;
    update();
  }

  bool cancelPressed = false;
  void cancelPressedFunc() {
    cancelPressed = true;
    update();
  }

  void cancelEdit() {
    currentUserData = preEditUserData;
    profileFormKey.currentState?.reset();
    editingInfo = false;
    setInfoToOriginal();
    cancelPressed = false;
    update();
  }

  void finishEdit() {
    saveChanges();
    editingInfo = false;
    update();
  }

  void setInfoToOriginal() {
    fullNameController.text = currentUserData!.fullName;
    gender = currentUserData!.gender;
    ageController.text = currentUserData!.age.toInt().toString();
    heightController.text = measurementSystem == 'metric'
        ? currentUserData!.height.toInt().toString()
        : '${(currentUserData!.height * 0.393701).toInt()}.';
    weightController.text = measurementSystem == 'metric'
        ? currentUserData!.weight.toInt().toString()
        : '${(currentUserData!.weight * 2.20462).toInt()}.';
    activityLevel = currentUserData!.activityLevel;
    proteinController.text =
        currentUserData!.proteinPercentage.toInt().toString();
    carbsController.text = currentUserData!.carbsPercentage.toInt().toString();
    fatController.text = currentUserData!.fatPercentage.toInt().toString();
    update();
  }

  void saveChanges() async {
    try {
      currentUserData!.fullName = fullNameController.text;
      currentUserData!.gender = gender!;
      currentUserData!.age = double.parse(ageController.text);
      currentUserData!.height = measurementSystem == 'imperial'
          ? double.parse(heightController.text) * 2.54
          : double.parse(heightController.text);
      currentUserData!.weight = measurementSystem == 'imperial'
          ? double.parse(weightController.text) * 0.453592
          : double.parse(weightController.text);
      currentUserData!.activityLevel = activityLevel!;
      currentUserData!.proteinPercentage = double.parse(proteinController.text);
      currentUserData!.carbsPercentage = double.parse(carbsController.text);
      currentUserData!.fatPercentage = double.parse(fatController.text);
      calculateDietaryMetrics(
        currentUserData!.height,
        currentUserData!.weight,
        currentUserData!.age,
        currentUserData!.proteinPercentage,
        currentUserData!.carbsPercentage,
        currentUserData!.fatPercentage,
        currentUserData!.gender,
        currentUserData!.activityLevel,
      );
      currentUserData!.bmr = bmr;
      currentUserData!.calories = calories;
      currentUserData!.proteinInGrams = proteinInGrams;
      currentUserData!.carbsInGrams = carbsInGrams;
      currentUserData!.fatInGrams = fatInGrams;
      currentUserData!.measurementSystem = measurementSystem;

      Map<String, dynamic> updatedData = {
        'fullName': fullNameController.text,
        'gender': gender!,
        'age': double.parse(ageController.text),
        'height': measurementSystem == 'imperial'
            ? double.parse(heightController.text) * 2.54
            : double.parse(heightController.text),
        'weight': measurementSystem == 'imperial'
            ? double.parse(weightController.text) * 0.453592
            : double.parse(weightController.text),
        'activityLevel': activityLevel!,
        'proteinPercentage': double.parse(proteinController.text),
        'carbsPercentage': double.parse(carbsController.text),
        'fatPercentage': double.parse(fatController.text),
        'bmr': bmr,
        'calories': calories,
        'proteinInGrams': proteinInGrams,
        'carbsInGrams': carbsInGrams,
        'fatInGrams': fatInGrams,
        'measurementSystem': measurementSystem
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserData!.userId)
          .update(updatedData);

      update();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Error updating user data: ${e.code}');
      }
    }
  }

  final takeAMeasurementFormKey = GlobalKey<FormState>();
  void selectMeasurementGender(String? selectedGender) {
    measureGender = selectedGender;
    update();
  }

  void selectMeasurementActivityLevel(String? selectedActivityLevel) {
    measureActivityLevel = selectedActivityLevel;
    update();
  }

  double bmr = 0;
  double calories = 0;
  double proteinInGrams = 0;
  double carbsInGrams = 0;
  double fatInGrams = 0;
  bool completedCalculations = false;
  Future calculateDietaryMetrics(
    double height,
    double weight,
    double age,
    double protein,
    double carbs,
    double fat,
    String gender,
    String activityLevel,
  ) async {
    try {
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
      completedCalculations = true;
      update();
    } catch (e) {
      completedCalculations = false;
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  Future takeAMeasurement() async {
    try {
      calculateDietaryMetrics(
        measurementSystem == 'imperial'
            ? double.parse(measureHeightController.text) * 2.54
            : double.parse(measureHeightController.text),
        measurementSystem == 'imperial'
            ? double.parse(measureWeightController.text) * 0.453592
            : double.parse(measureWeightController.text),
        double.parse(measureAgeController.text),
        double.parse(measureProteinController.text),
        double.parse(measureCarbsController.text),
        double.parse(measureFatController.text),
        measureGender!,
        measureActivityLevel!,
      );
      Measurement measurement = Measurement(
        fullName: measureFullNameController.text,
        gender: measureGender!,
        age: double.parse(measureAgeController.text),
        height: measurementSystem == 'imperial'
            ? double.parse(measureHeightController.text) * 2.54
            : double.parse(measureHeightController.text),
        weight: measurementSystem == 'imperial'
            ? double.parse(measureWeightController.text) * 0.453592
            : double.parse(measureWeightController.text),
        activityLevel: measureActivityLevel!,
        proteinPercentage: double.parse(measureProteinController.text),
        carbsPercentage: double.parse(measureCarbsController.text),
        fatPercentage: double.parse(measureFatController.text),
        bmr: bmr,
        calories: calories,
        proteinInGrams: proteinInGrams,
        carbsInGrams: carbsInGrams,
        fatInGrams: fatInGrams,
        measurementSystem: measurementSystem,
        date: DateFormat('dd-MM-yy').format(DateTime.now()),
      );
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserData!.userId)
          .collection('measurements')
          .add(
            measurement.toJson(),
          );
      measurement.measurementId = documentReference.id;
      documentReference.update({'measurementId': documentReference.id});
      userMeasurements.add(measurement);
      update();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
    }
  }

  List<Measurement> userMeasurements = [];
  Future fetchMeasurements() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserData!.userId)
          .collection('measurements')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        userMeasurements.add(
          Measurement.fromJson(
            doc.data() as Map<String, dynamic>,
          ),
        );
      }
      update();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
    }
  }

  void showDialogue(
      bool isError, String errorText, Function? confirm, String message) {
    Get.dialog(
      barrierDismissible: false,
      Center(
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
                text: (isError) ? errorText.tr : message.tr,
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
                            if (confirm != null) {
                              confirm();
                            }
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

  void logOut() async {
    try {
      activateLoading();
      await FirebaseAuth.instance.signOut();
      // await GoogleSignIn().signOut();
      disableLoading();
      loginCheck!.clear();
      Get.offAllNamed('/');
    } on FirebaseAuthException catch (e) {
      disableLoading();
      if (kDebugMode) {
        print('Error logging out: ${e.code}');
      }
    }
    update();
  }

  bool listEditingMode = false;
  void changeEditingMode(bool activation) {
    listEditingMode = activation;
    update();
  }

  List<dynamic> toBeDeleted = [];
  void selectListElement(String id) {
    changeEditingMode(true);
    if (toBeDeleted.contains(id)) {
      toBeDeleted.remove(id);
    } else {
      toBeDeleted.add(id);
    }
    update();
  }

  void deleteItems() async {
    try {
      for (dynamic id in toBeDeleted) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserData!.userId)
            .collection('measurements')
            .doc(id)
            .delete();
        userMeasurements
            .removeWhere((measurement) => measurement.measurementId == id);
      }
      cancelListEditing();
      update();
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  void cancelListEditing() {
    changeEditingMode(false);
    toBeDeleted.clear();
    update();
  }
}
