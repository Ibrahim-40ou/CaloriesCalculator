import 'package:calories_calculator/Controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
