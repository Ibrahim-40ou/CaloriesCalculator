import 'package:calories_calculator/Widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

class SecondaryInfo extends StatelessWidget {
  final int protein;
  final int carbs;
  final int fat;
  final int calories;
  final String energyUnit;
  final String measurementSystem;
  const SecondaryInfo({
    super.key,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.calories,
    required this.energyUnit,
    required this.measurementSystem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyCard(
              buttonColor: const Color(0xFFFFE5E5),
              label: 'protein'.tr,
              text: '$protein${'g'.tr}',
              textsColor: MyColors().myRed,
              function: () {},
              path: 'assets/Biotech.png',
            ),
            MyCard(
              buttonColor: const Color(0xFFFFE5E5),
              label: 'gain weight'.tr,
              text: energyUnit == 'calories'
                  ? '${calories + 500} ${'calories'.tr}'
                  : '${((calories + 500) * 4.184).toInt()} ${'joules'.tr}',
              textsColor: MyColors().myRed,
              function: () {},
              path: measurementSystem == 'metric' ? 'assets/KiloRed.png' : 'assets/poundRed.png',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyCard(
              buttonColor: const Color(0xFFD9E6FF),
              label: 'carbs'.tr,
              text: '$carbs${'g'.tr}',
              textsColor: MyColors().myBlue,
              function: () {},
              path: 'assets/Barley.png',
            ),
            MyCard(
              buttonColor: const Color(0xFFD9E6FF),
              label: 'maintenance'.tr,
              text: energyUnit == 'calories'
                  ? '$calories ${'calories'.tr}'
                  : '${(calories * 4.184).toInt()} ${'joules'.tr}',
              textsColor: MyColors().myBlue,
              function: () {},
              path: measurementSystem == 'metric' ? 'assets/KiloBlue.png' : 'assets/poundBlue.png',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyCard(
              buttonColor: const Color(0xFFFFEED9),
              label: 'fat'.tr,
              text: '$fat${'g'.tr}',
              textsColor: MyColors().myBrown,
              function: () {},
              path: 'assets/Blur.png',
            ),
            MyCard(
              buttonColor: const Color(0xFFFFEED9),
              label: 'lose weight'.tr,
              text: energyUnit == 'calories'
                  ? '${calories - 500} ${'calories'.tr}'
                  : '${((calories - 500) * 4.184).toInt()} ${'joules'.tr}',
              textsColor: MyColors().myBrown,
              function: () {},
              path: measurementSystem == 'metric' ? 'assets/kiloBrown.png' : 'assets/poundBrown.png',
            ),
          ],
        ),
      ],
    );
  }
}
