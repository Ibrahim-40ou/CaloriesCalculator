import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calories_calculator/colors.dart';

class MyField extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool showPassword;
  final bool isLast;
  final bool isName;
  final TextInputType type;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Function? suffixIconFunction;
  final String? Function(String?)? validatorFunction;
  final bool? enabled;

  const MyField({
    super.key,
    required this.width,
    required this.controller,
    required this.hintText,
    required this.isPassword,
    this.showPassword = false,
    required this.isLast,
    required this.isName,
    required this.type,
    required this.prefixIcon,
    this.suffixIcon,
    this.suffixIconFunction,
    this.validatorFunction,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: showPassword,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        textCapitalization:
            isName ? TextCapitalization.sentences : TextCapitalization.none,
        keyboardType: type,
        style: GoogleFonts.rubik(
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.rubik(
            color: Colors.grey,
            fontSize: 14,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: MyColors().myBlue,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: MyColors().myRed,
              width: 1,
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    if (suffixIconFunction != null) suffixIconFunction!();
                  },
                  icon: suffixIcon!,
                )
              : suffixIcon,
          errorStyle: GoogleFonts.rubik(
            fontSize: 14,
            color: MyColors().myRed,
            fontWeight: FontWeight.normal,
          ),
          errorMaxLines: 10,
        ),
        validator: validatorFunction,
      ),
    );
  }
}
