import 'package:calories_calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controllers/home_controller.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.find();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (builder) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: controller.changePage,
            children: controller.pageViewItems,
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            onTap: controller.changePage,
            currentIndex: controller.currentIndex,
            items: controller.navigationBarItems,
            selectedLabelStyle: GoogleFonts.rubik(
              color: MyColors().myGreen,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: GoogleFonts.rubik(
              color: MyColors().myGreen,
              fontWeight: FontWeight.normal,
            ),
            selectedItemColor: MyColors().myGreen,
            unselectedItemColor: MyColors().myGreen,
          ),
        ),
      ),
    );
  }
}
