import 'package:calories_calculator/Widgets/app_bar.dart';
import 'package:calories_calculator/Widgets/button.dart';
import 'package:calories_calculator/Widgets/text.dart';
import 'package:calories_calculator/Widgets/text_form_field.dart';
import 'package:calories_calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/auth_controller.dart';

class ForgotPassword extends StatelessWidget {
  final AuthController controller = Get.find();
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (builder) {
        if (controller.passwordResetError) {
          Future.microtask(
            () => controller.showDialogue(
              controller.passwordResetError,
              controller.errorText,
              null,
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async {
            controller.showDialogue(
              controller.passwordResetError,
              controller.errorText,
              controller.onLeavePasswordReset,
            );
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MyAppBar(
                title: 'password reset'.tr,
                leadingExists: true,
                leadingFunction: () {
                  controller.showDialogue(
                    controller.passwordResetError,
                    controller.errorText,
                    controller.onLeavePasswordReset,
                  );
                },
              ),
              body: Form(
                key: controller.resetPasswordFormKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            text:
                                'we will send a password reset link to the email you enter'.tr,
                            size: 22,
                            weight: FontWeight.normal,
                            color: Colors.black,
                            align: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(height: 20),
                          MyField(
                            width: 100.w,
                            controller: controller.forgotPasswordController,
                            hintText: 'email'.tr,
                            isPassword: false,
                            isLast: true,
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
                          const SizedBox(height: 40),
                          MyButton(
                            buttonFunction: () {
                              if (controller.resetPasswordFormKey.currentState!
                                  .validate()) {
                                controller.resetPassword();
                              }
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
                                        text: 'sending'.tr,
                                        size: 16,
                                        weight: FontWeight.normal,
                                        color: Colors.white,
                                        align: TextAlign.left,
                                      ),
                                    ],
                                  )
                                : MyText(
                                    text: 'send'.tr,
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
