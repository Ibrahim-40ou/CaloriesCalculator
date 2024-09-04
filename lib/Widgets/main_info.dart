import 'package:calories_calculator/Widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

class MainInfo extends StatelessWidget {
  final int bmr;
  final int weight;
  final String activityLevel;
  final String measurementSystem;
  final String energyUnit;
  final bool dashboard;
  const MainInfo({
    super.key,
    required this.bmr,
    required this.weight,
    required this.activityLevel,
    required this.measurementSystem,
    required this.dashboard,
    required this.energyUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE5FFEA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 74.w,
                      child: MyText(
                        text: 'basal metabolic rate'.tr,
                        size: 20,
                        weight: FontWeight.normal,
                        color: MyColors().myGreen,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MyText(
                      text: energyUnit == 'calories'
                          ? '$bmr ${'calories'.tr}'
                          : '${(bmr * 4.184).toInt()} ${'joules'.tr}',
                      size: 16,
                      weight: FontWeight.normal,
                      color: MyColors().myGreen,
                    ),
                  ],
                ),
                Icon(
                  Icons.man,
                  color: MyColors().myGreen,
                  size: 24,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 74.w,
                      child: MyText(
                        text: dashboard ? 'current weight'.tr : 'weight'.tr,
                        size: 20,
                        weight: FontWeight.normal,
                        color: MyColors().myGreen,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MyText(
                      text: measurementSystem == 'metric' ? '$weight${'kg'.tr}' : '${(weight*2.20462).toInt()}${'lb'.tr}',
                      size: 16,
                      weight: FontWeight.normal,
                      color: MyColors().myGreen,
                    ),
                  ],
                ),
                (measurementSystem == 'metric')
                    ? Image.asset('assets/kiloGreen.png')
                    : Image.asset('assets/poundGreen.png'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 74.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'activity level'.tr,
                        size: 20,
                        weight: FontWeight.normal,
                        color: MyColors().myGreen,
                      ),
                      MyText(
                        text: activityLevel.tr,
                        size: 16,
                        weight: FontWeight.normal,
                        color: MyColors().myGreen,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/RunningGreen.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
