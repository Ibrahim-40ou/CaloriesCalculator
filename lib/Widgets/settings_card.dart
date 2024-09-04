import 'package:calories_calculator/Widgets/button.dart';
import 'package:calories_calculator/Widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCard extends StatelessWidget {
  final Color buttonColor;
  final String label;
  final String text;
  final String? subText;
  final Color textsColor;
  final String? path;
  final String? trailingText;
  final Function function;
  const MyCard({
    super.key,
    required this.buttonColor,
    required this.label,
    required this.text,
    required this.textsColor,
    required this.function,
    this.path,
    this.subText,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 4,
          ),
        ],
      ),
      child: MyButton(
        buttonFunction: () {
          function();
        },
        height: 100,
        width: (Get.width - 60) / 2,
        color: buttonColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: label,
                      size: 16,
                      weight: FontWeight.normal,
                      color: textsColor,
                    ),
                    MyText(
                      text: text,
                      size: 14,
                      weight: FontWeight.normal,
                      color: textsColor,
                    ),
                    (subText != null)
                        ? MyText(
                            text: subText!,
                            size: 14,
                            weight: FontWeight.normal,
                            color: textsColor,
                          )
                        : Container(),
                  ],
                ),
                (path != null)
                    ? Image.asset(path!)
                    : (trailingText != null)
                        ? MyText(
                            text: trailingText!,
                            size: 20,
                            weight: FontWeight.normal,
                            color: textsColor,
                          )
                        : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
