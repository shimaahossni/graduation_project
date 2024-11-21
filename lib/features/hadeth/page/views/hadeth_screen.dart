// features/hadeth/page/views/hadeth_screen.dart
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/hadeth/presentation/bloc/hadith_time_bloc.dart';

class HadethScreen extends StatefulWidget {
  HadethScreen({super.key});

  //late final HadithDetails hadithDetails;

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}

class _HadethScreenState extends State<HadethScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HadithTimeBloc>().add(GetHadithTimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          ///////////////////////////////////////////////////bg image
          Image.asset(
            AppImages.hadethBgPng,
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

          ///////////////////////////////////////////////////body
          BlocBuilder<HadithTimeBloc, HadithTimeState>(
            builder: (context, state) {
              if (state is HadithTimeSuccess) {
                var hadith = context.read<HadithTimeBloc>().hadithDetails;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(mediaquery.height * .12),
                    SvgPicture.asset(AppImages.Islami_logo_textSvg),

                    //////////////////////////////////////////slider listView for hadeth details

                    Gap(mediaquery.height * .05),
                    CarouselSlider.builder(
                      itemCount: hadith?.length,
                      options: CarouselOptions(
                        height: mediaquery.height / 1.5,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.25,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          width: mediaquery.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ///////////////////////////////////////////////////slider bg image
                              Image.asset(
                                AppImages.onboardPng3,
                                color: AppColors.blackColor.withOpacity(.2),
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: Image.asset(
                                    AppImages.Mask1Png,
                                    width: mediaquery.width / 1.2,
                                    color: AppColors.blackColor.withOpacity(.5),
                                  )),
                              Positioned(
                                top: 10,
                                right: mediaquery.width * .5,
                                child: Image.asset(
                                  scale: 3.5,
                                  AppImages.MaskPng,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: mediaquery.width * .5,
                                child: Image.asset(
                                  scale: 3.5,
                                  AppImages.mask2Png,
                                  color: AppColors.blackColor,
                                ),
                              ),

                              ////////////////////////////////////////hadeth list
                              SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    Gap(mediaquery.height * .04),
                                    Gap(mediaquery.height * .04),
                                    Text(
                                      'Hadith ${hadith?[index].number.toString() ?? ""}',
                                      style: gettitleTextStyle24(
                                          color: AppColors.blackColor),
                                    ),
                                    Gap(20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        hadith?[index].arab ?? "",
                                        style: gettitleTextStyle18(
                                            color: AppColors.blackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );

                ///////////////////////////////////////////state error
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            },
          ),
        ],
      )),
    );
  }
}
