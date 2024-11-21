// features/intro/onboard/presentation/widgets/arabic_english_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';

class ArabicEnglishContainer extends StatelessWidget {
  const ArabicEnglishContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            border: Border.all(color: AppColors.primaryColor, width: 2),
          ),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                child: CircleAvatar(
                  child: SvgPicture.asset(
                    AppImages.englishSvg,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: CircleAvatar(
                  child: SvgPicture.asset(
                    AppImages.arabicSvg,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
