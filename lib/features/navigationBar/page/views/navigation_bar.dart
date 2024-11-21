// features/navigationBar/page/views/navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_icons.dart';
import 'package:islami/features/hadeth/page/views/hadeth_screen.dart';
import 'package:islami/features/prayerTime/page/views/prayer_time_screen.dart';
import 'package:islami/features/quran/page/views/quran_screen.dart';
import 'package:islami/features/seb7a/page/views/seb7a_screen.dart';
import 'package:islami/features/today_werd/page/views/today_werd.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    QuranScreen(),
    HadethScreen(),
    SebhaScreen(),
    PrayerTimeScreen(),
    TodayWerd()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          currentIndex = index;

          setState(() {});
          ///////////////////change button color
        },
        backgroundColor: AppColors.primaryColor,
        items: [
          //////////////////////////////////////////////quran icon
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.bookSvg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.bookSvg,
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor,
                    BlendMode.srcIn,
                  )),
              label: "Quran"),

          /////////////////////////////////////////hadeth icon
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.vectorSvg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.vectorSvg,
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor,
                    BlendMode.srcIn,
                  )),
              label: "hadeth"),

          //////////////////////////////////////////////sebha
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.seb7aSvg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.seb7aSvg,
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor,
                    BlendMode.srcIn,
                  )),
              label: "sebha"),

          //////////////////////////////////////////////prayer
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.Vector1Svg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.Vector1Svg,
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor,
                    BlendMode.srcIn,
                  )),
              label: "Prayer"),

          ////////////////////////////////////////////werd
          BottomNavigationBarItem(
              icon: Icon(Icons.alarm_on_sharp), label: "werd"),
        ],

        ///////////////////////////////////////////////selected Item
        selectedItemColor: AppColors.whiteColor,
        selectedLabelStyle: gettitleTextStyle14(),

        /////////////////////////////////////////////unselected Item
        showUnselectedLabels: false,
      ),
    );
  }
}
