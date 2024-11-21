// features/today_werd/page/widget/date_time.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/today_werd/page/views/add_new_task.dart';

class DateAndAddTaskButton extends StatefulWidget {
  const DateAndAddTaskButton({super.key});

  @override
  State<DateAndAddTaskButton> createState() => _DateAndAddTaskButtonState();
}

class _DateAndAddTaskButtonState extends State<DateAndAddTaskButton> {
  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    DateTime focusDate = DateTime.now();
    String date = DateFormat.yMMMMd().format(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: mediaquery.width * .06,
                  fontWeight: FontWeight.bold),
            ),
            Text(
                (DateFormat.E().format(focusDate)) ==
                        (DateFormat.E().format(focusDate))
                    ? "Today"
                    : DateFormat.E().format(focusDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: mediaquery.width * .06,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          width: mediaquery.width * .1,
        ),
        ///////////////////////////////////////////////button
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
            ),
            onPressed: () {
              pushTo(context, AddNewTask());
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Werd")),
      ],
    );
  }
}
