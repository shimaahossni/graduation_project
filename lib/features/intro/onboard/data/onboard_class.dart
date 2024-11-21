// features/intro/onboard/data/onboard_class.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/intro/onboard/page/widgets/arabic_english_container.dart';

class onBoardClass {
  String title;
  String centerImage;
  String content;
  Widget? description;
  String? descriptionText;

  onBoardClass(
      {required this.title,
      required this.centerImage,
      required this.content,
      this.description,
      this.descriptionText});
}

List<onBoardClass> onboardContents = [
  /////////////////////////////////////////////////////////////first onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng1,
    content: "Chose Language",
    description: ArabicEnglishContainer(),
  ),

  /////////////////////////////////////////////////////////////second onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng2,
    content: "Welcome To Islami",
    descriptionText: "We Are Very Excited To Have You In\n Our Community",
  ),

  /////////////////////////////////////////////////////////////third onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng3,
    content: "Reading the Quran",
    descriptionText: "Read, and your Lord is the Most Generous",
  ),

  ///////////////////////////////////////////////////////////fourth onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng4,
    content: "Bearish",
    descriptionText: "Praise the name of your Lord, the\n Most High",
  ),

  ///////////////////////////////////////////////////////////fifth onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng5,
    content: "Holy Quran Radio",
    descriptionText:
        "You can listen to the Holy Quran\n Radio through the application for\n free and easily",
  ),
];
