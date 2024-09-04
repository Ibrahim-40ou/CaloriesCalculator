import 'package:calories_calculator/Controllers/auth_controller.dart';
import 'package:calories_calculator/Widgets/app_bar.dart';
import 'package:calories_calculator/Widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text.dart';
import '../../colors.dart';

class CreateProfile extends StatelessWidget {
  final AuthController controller = Get.find();
  CreateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (builder) {
        if (controller.registerError) {
          Future.microtask(
            () => controller.showDialogue(
              controller.registerError,
              controller.errorText,
              null,
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async {
            controller.showDialogue(
              controller.registerError,
              controller.errorText,
              controller.onLeaveRegister,
            );
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MyAppBar(
                title: 'create profile'.tr,
                leadingExists: true,
                leadingFunction: () {
                  controller.showDialogue(
                    controller.registerError,
                    controller.errorText,
                    controller.onLeaveRegister,
                  );
                },
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.createProfileFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyField(
                            width: 100.w,
                            controller: controller.fullNameController,
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
                            suffixIcon: null,
                            suffixIconFunction: null,
                            validatorFunction: controller.validateName,
                          ),
                          const SizedBox(height: 20),
                          MyField(
                            width: 100.w,
                            controller: controller.newEmailController,
                            hintText: 'email'.tr,
                            isPassword: false,
                            isLast: false,
                            isName: false,
                            type: TextInputType.text,
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 24,
                              color: Colors.black,
                            ),
                            suffixIcon: null,
                            suffixIconFunction: null,
                            validatorFunction: controller.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          MyField(
                            width: 100.w,
                            controller: controller.newPasswordController,
                            hintText: 'password'.tr,
                            isPassword: true,
                            showPassword: controller.showPasswordRegister,
                            isLast: true,
                            isName: false,
                            type: TextInputType.text,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 24,
                              color: Colors.black,
                            ),
                            suffixIcon: controller.showPasswordRegister
                                ? const Icon(
                                    CupertinoIcons.eye,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                            suffixIconFunction:
                                controller.showPasswordFunctionRegister,
                            validatorFunction: controller.validatePassword,
                          ),
                          const SizedBox(height: 40),
                          MyButton(
                            buttonFunction: () {
                              if (controller.createProfileFormKey.currentState!
                                  .validate()) {
                                Get.toNamed('/take_measurements');
                              }
                            },
                            height: 40,
                            width: 100.w,
                            color: MyColors().myGreen,
                            child: MyText(
                              text: 'continue'.tr,
                              size: 16,
                              weight: FontWeight.normal,
                              color: Colors.white,
                              align: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
