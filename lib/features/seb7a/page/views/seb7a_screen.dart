// features/seb7a/page/views/seb7a_screen.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  double _rotationAngle = 0.0;
  int counter = 0;
  int currentindex = 0;

  List<String> changeTasbeh = [
    'سبحان الله',
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'الْحَمْدُ لِلَّهِ'
  ];

  void _rotateImage() {
    setState(() {
      counter++;
      _rotationAngle += 45.0;

      // Check if counter has reached 99 degrees return to 0
      counter == 100 ? counter = 0 : counter;
      if (counter < 30) {
        AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey, counter.toString());
        currentindex = 0;
      } else if (counter < 60 && counter > 30) {
        AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey, counter.toString());
        currentindex = 1;
      } else if (counter < 90 && counter > 60) {
        AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey, counter.toString());
        currentindex = 2;
      } else {
        AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey, counter.toString());
        currentindex = 0;
      }
      // Rotate by 45 degrees on each tap
    });
  }

  @override
  Widget build(BuildContext context) {
    //  AppLocalStorage.cachedSebhaData(
    //    AppLocalStorage.sebhaKey, counter.toString());
    // AppLocalStorage.getCachedSebhaData(AppLocalStorage.sebhaKey);
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ///////////////////////////////////////////////////bg image
            Image.asset(
              AppImages.seb7aPng,
              fit: BoxFit.cover,
            ),

            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.black.withOpacity(
                    0.01,
                  ),
                ),
              ),
            ),
            Positioned(
              left: mediaquery.width * .1,
              child: Image.asset(
                AppImages.decorate_bgPng,
                width: mediaquery.height / 2.8,
              ),
            ),

            ////////////////////////////////////////////////////////////////page content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///////////////////////////////////////logo
                  SvgPicture.asset(AppImages.Islami_logo_textSvg),
                  const Gap(30),

                  ///////////////////////////////////////title
                  Text(
                    "سَبِّحِ اسْمَ رَبِّكَ الأعلى ",
                    style: gettitleTextStyle36(color: AppColors.whiteColor),
                  ),
                  const Gap(20),

                  ///////////////////////////////////////seb7a body
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(50),
                      Image.asset(
                        AppImages.upPng,
                        width: 70,
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                          onTap: _rotateImage,
                          child: Transform.rotate(
                              angle:
                                  _rotationAngle * (3.1415926535897932 / 180.0),
                              child: SvgPicture.asset(AppImages.SebhaBodySvg))),
                      Column(
                        children: [
                          Text(
                            changeTasbeh[currentindex],
                            style: gettitleTextStyle36(
                                color: AppColors.whiteColor),
                          ),
                          Text(
                            //counter.toString(),
                            AppLocalStorage.getCachedSebhaData(
                                AppLocalStorage.sebhaKey),

                            style: gettitleTextStyle36(
                                color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
