import 'package:calories_calculator/View/App/take_a_measurement.dart';
import 'package:calories_calculator/View/Auth/forgot_password.dart';
import 'package:calories_calculator/View/Auth/take_measurements.dart';
import 'package:calories_calculator/translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Bindings/auth_bindings.dart';
import 'Bindings/home_bindings.dart';
import 'View/App/home.dart';
import 'View/App/profile.dart';
import 'View/Auth/create_profile.dart';
import 'View/Auth/login.dart';
import 'firebase_options.dart';

SharedPreferences? loginCheck;
SharedPreferences? langCheck;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );
  loginCheck = await SharedPreferences.getInstance();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLanguageCode = prefs.getString('languageCode');

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        translations: MyTranslations(),
        locale: savedLanguageCode != null
            ? Locale(savedLanguageCode)
            : const Locale('en'),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        getPages: [
          GetPage(
            name: '/',
            page: () =>
                loginCheck!.getString('loggedIn') == null ? Login() : Home(),
            bindings: (loginCheck!.getString('loggedIn') == null)
                ? [AuthBindings()]
                : [AuthBindings(), HomeBindings()],
          ),
          GetPage(
            name: '/password_reset',
            page: () => ForgotPassword(),
            binding: AuthBindings(),
          ),
          GetPage(
            name: '/create_profile',
            page: () => CreateProfile(),
            binding: AuthBindings(),
          ),
          GetPage(
            name: '/take_measurements',
            page: () => Measurements(),
            binding: AuthBindings(),
          ),
          GetPage(
            name: '/home',
            page: () => Home(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/profile',
            page: () => const Profile(),
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/take_a_measurement',
            page: () => const TakeAMeasurement(),
            binding: HomeBindings(),
          ),
        ],
      ),
    ),
  );
}
