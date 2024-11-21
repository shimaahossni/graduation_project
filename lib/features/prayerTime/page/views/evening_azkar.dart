// features/prayerTime/page/views/evening_azkar.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/prayerTime/presentation/bloc/azkar_bloc.dart';

class EveningAzkar extends StatefulWidget {
  const EveningAzkar({super.key});

  @override
  State<EveningAzkar> createState() => _EveningAzkarState();
}

class _EveningAzkarState extends State<EveningAzkar> {
  @override
  void initState() {
    super.initState();
    context.read<AzkarBloc>().add(GetAzkarEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AzkarBloc, azkarState>(
        builder: (context, state) {
          var azkarToday = context.read<AzkarBloc>().azkarDetails;
          if (state is azkarSuccess) {
            print(azkarToday);
          } else {
            return Text(azkarToday.length.toString());
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        " azkarToday[index].id.toString()",
                        style: gettitleTextStyle36(color: AppColors.blackColor),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
