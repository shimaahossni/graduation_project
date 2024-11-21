// features/quran/page/views/surah_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/quran/presentation/bloc/quran_time_bloc.dart';

class SurahDetails extends StatelessWidget {
  const SurahDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return BlocBuilder<QuranTimeBloc, QuranTimeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            foregroundColor: AppColors.primaryColor,
            backgroundColor: AppColors.blackColor,
            title: Text(
              "Al-Fatiha",
              style: gettitleTextStyle20(),
            ),
            centerTitle: true,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AppImages.SouraDetailsScreenPng),
              Positioned(
                  top: mediaquery.height * .05,
                  left: mediaquery.width * .4,
                  child: Text("الفاتحة", style: gettitleTextStyle20())),
              Column(
                children: [
                  Gap(mediaquery.height * .04),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: mediaquery.width * .08,
                        vertical: mediaquery.height * .08),
                    height: mediaquery.height / 1.65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                    ),
                    child: Text(
                      "Surah details",
                      style: gettitleTextStyle20(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
