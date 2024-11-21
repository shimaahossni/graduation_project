// features/prayerTime/page/views/prayer_time_screen.dart
import 'dart:ui';
import 'package:adhan/adhan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/prayerTime/page/views/evening_screen_another.dart';
import 'package:islami/features/prayerTime/page/widget/azkar_gridview.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  String? _currentAddress;
  Position? _currentPostion;

  Future<bool> _handleLocationPersmission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enable Location service')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Location service is denied')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPersmission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPostion = position);
      _getAddressFromLatLng(_currentPostion!);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPostion!.latitude, _currentPostion!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street} '
            ',${place.subLocality} ,${place.country}  ,${place.postalCode} ';
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    List<String> gridviewAzkari = [
      'Evening Azkar',
      'Sleeping Azkar',
      'Morning Azkar',
      //'Morning Azkar'
    ];

    //////////////////////////////////////////////////////////adhan package
    final myCoordinates = Coordinates(
        _currentPostion?.latitude ?? 0, _currentPostion?.longitude ?? 0);

    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    final latPosition = _currentPostion?.latitude ?? 0;
    final longPosition = _currentPostion?.longitude ?? 0;
    final accPosition = _currentPostion?.accuracy ?? 0;
    final altPosition = _currentPostion?.altitude ?? 0;
    final spePosition = _currentPostion?.speed ?? 0;
    final currentAddress = _currentAddress ?? "";

    ///////////////////////////////////////////////////list
    final fajr = DateFormat.jm().format(prayerTimes.fajr);
    final dhuhr = DateFormat.jm().format(prayerTimes.dhuhr);
    final asr = DateFormat.jm().format(prayerTimes.asr);
    final maghrib = DateFormat.jm().format(prayerTimes.maghrib);
    final isha = DateFormat.jm().format(prayerTimes.isha);
    List<String> prayerTimesList = [fajr, dhuhr, asr, maghrib, isha];
    List<String> prayerTimesName = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];
    String date = DateFormat.EEEE().format(DateTime.now());
    String date2 = DateFormat.y().format(DateTime.now());
    String date3 = DateFormat.MMMd().format(DateTime.now());
    var _today = HijriCalendar.now();

    return Scaffold(
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          ///////////////////////////////////////////////////bg image
          Image.asset(
            AppImages.prayer_time_bgPng,
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

          //////////////////////////////////////////////////////////////////////////////////////////////body
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(mediaquery.height * .12),
              SvgPicture.asset(AppImages.Islami_logo_textSvg),

              //////////////////////////////////prayer time container

              Gap(mediaquery.height * .02),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaquery.width * .02),
                child: Container(
                  width: double.infinity,
                  height: mediaquery.height / 3,
                  decoration: BoxDecoration(
                    color: AppColors.sliderContainerColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AppImages.prayerSliderPng,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        children: [
                          //////////////////////////////////////prayer date and time hijri and meladi
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${date3} ,\n${date2}",
                                style: gettitleTextStyle16(
                                    color: AppColors.whiteColor),
                              ),
                              Text(
                                "Pray Time\n${date}",
                                style: gettitleTextStyle20(
                                    color: AppColors.blackColor),
                              ),
                              Text(
                                "${_today.hDay} ${_today.getShortMonthName()},\n${_today.hYear}",
                                style: gettitleTextStyle16(
                                    color: AppColors.whiteColor),
                              ),
                            ],
                          ),

                          /////////////////////////////////////////////////////slider from adhan package
                          Gap(mediaquery.height * .03),
                          CarouselSlider.builder(
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: mediaquery.width * .02),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment(0.8, 1),
                                      colors: <Color>[
                                        Color(0xff202020),
                                        Color(0xffB19768),
                                      ],
                                      tileMode: TileMode.mirror,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        prayerTimesName[index],
                                        style: gettitleTextStyle18(
                                            color: AppColors.whiteColor),
                                      ),
                                      Text(
                                        prayerTimesList[index],
                                        style: gettitleTextStyle30(
                                            color: AppColors.whiteColor),
                                      ),
                                    ],
                                  ));
                            },
                            options: CarouselOptions(
                              height: mediaquery.height / 5,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.4,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(mediaquery.height * .02),
              Row(
                children: [
                  Gap(mediaquery.width * .04),
                  Text(
                    "Azkar",
                    style: gettitleTextStyle16(color: AppColors.whiteColor),
                  ),
                  Gap(mediaquery.height * .02),
                ],
              ),

              /////////////////////////////////////////////////////////////////gridview azkar
              Gap(mediaquery.height * .02),
              Container(
                width: mediaquery.width * .95,
                height: mediaquery.height * .3,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.builder(
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        pushTo(
                            context,
                            EveningScreenAnother(
                              pageNumber: index,
                            ));
                      },
                      child: AzkarGridview(
                        text: gridviewAzkari[index],
                        image: AppImages.azkar1Png,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
