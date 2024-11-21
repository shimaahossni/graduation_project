// features/quran/page/views/quran_screen.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/quran/data/models/response/quran_details/quran_details.dart';
import 'package:islami/features/quran/page/widgets/search_textfield.dart';
import 'package:islami/features/quran/presentation/bloc/quran_time_bloc.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<QuranTimeBloc>().add(GetQuranTimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ///////////////////////////////////////////////////bg image
          Image.asset(
            AppImages.layoutBgPng,
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

          ///////////////////////////////////////////////////////////body
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Gap(mediaquery.height * .1),
                SvgPicture.asset(AppImages.Islami_logo_textSvg),

                ////////////////////////////////////////////seach bar
                Gap(mediaquery.height * .03),
                SearchTextfield(
                  hinttext: "sura name",
                ),

                /////////////////////////////////////////////text
                Gap(20),
                Row(
                  children: [
                    Text(
                      "Suras List",
                      style: gettitleTextStyle16(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
                //////////////////////////////////////////////////surah list

                Expanded(
                  child: BlocBuilder<QuranTimeBloc, QuranTimeState>(
                    builder: (context, state) {
                      if (state is QuranTimeSuccess) {
                        var surahList = context.read<QuranTimeBloc>().surahs;
                        print("000000000000000000000000000000${surahList}");
                        return ListView.separated(
                          ////////////////////////length
                          itemCount: surahList.length,

                          ///////////////////////////////listview builder
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    /////////////surah number
                                    surahList[index].name.toString(),
                                    style: gettitleTextStyle20(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  SvgPicture.asset(AppImages.surah_vectorSvg),
                                ],
                              ),
                              title: Text(
                                /////////////////////////surah name
                                surahList[index].englishName.toString(),
                                style: gettitleTextStyle20(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              subtitle: Text(
                                  surahList[index].revelationType.toString(),
                                  style: gettitleTextStyle14(
                                      color: AppColors.whiteColor)),
                              trailing: Text(
                                surahList[index].name.toString(),
                                style: gettitleTextStyle20(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              endIndent: mediaquery.width * .1,
                              indent: mediaquery.width * .1,
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            "no dataaaaaaaaaaaa",
                            style: gettitleTextStyle36(),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
