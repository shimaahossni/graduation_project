// features/today_werd/page/views/add_new_task.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/today_werd/data/task_model.dart';
import 'package:islami/features/today_werd/page/widget/custom_button.dart';
import 'package:islami/features/today_werd/page/widget/textfieldflorm_widget.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({super.key, this.taskmodel});

  final TaskMdel? taskmodel;

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var formKey = GlobalKey();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  var starttimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  var endtimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  int selectedColor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //titleController.text = widget.taskmodel?.title ?? " ";
    titleController = TextEditingController(text: widget.taskmodel?.title);
    noteController = TextEditingController(text: widget.taskmodel?.note);
    dateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    starttimeController = TextEditingController(
        text: DateFormat('hh:mm a').format(DateTime.now()));
    endtimeController = TextEditingController(
        text: DateFormat('hh:mm a').format(DateTime.now()));
    selectedColor = widget.taskmodel?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.withOpacity(.2),
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: gettitleTextStyle24(),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.withOpacity(.03),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //////////////////////////////////////////////title
                Text(
                  "Title",
                  style: gettitleTextStyle20(),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                TextfieldflormWidget(
                  onTap: () {},
                  controller: titleController,
                  validator: (p0) =>
                      p0!.isEmpty ? "Please enter your title" : null,
                  isobsecure: false,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: mediaquery.height * .02,
                ),
                /////////////////////////////////////////////////////////////////note
                Text(
                  "Note",
                  style: gettitleTextStyle20(),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                TextfieldflormWidget(
                  onTap: () {},
                  // maxLength: 4,
                  isobsecure: false,
                  controller: noteController,
                  onChanged: (value) {},
                  validator: (p0) =>
                      p0!.isEmpty ? "Please enter your note" : null,
                ),
                SizedBox(
                  height: mediaquery.height * .02,
                ),

                ////////////////////////////////////////////////////////////////////date
                Text(
                  "Date",
                  style: gettitleTextStyle20(),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                TextfieldflormWidget(
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      if (value != null) {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(value);
                      }
                    });
                  },
                  controller: dateController,
                  readOnly: true,
                  isobsecure: false,
                  suffixIcon: const Icon(Icons.calendar_month,
                      color: AppColors.primaryColor),
                ),

                SizedBox(
                  height: mediaquery.height * .02,
                ),

                /////////////////////////////////////////////////////////Endtime&starttime
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Time",
                            style: gettitleTextStyle20(),
                          ),
                          SizedBox(
                            height: mediaquery.height * .01,
                          ),
                          TextfieldflormWidget(
                            onTap: () async {
                              await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  starttimeController.text =
                                      value.format(context);
                                }
                              });
                            },
                            controller: starttimeController,
                            readOnly: true,
                            isobsecure: false,
                            suffixIcon: const Icon(
                              Icons.access_time,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mediaquery.width * .02,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Time",
                            style: gettitleTextStyle20(),
                          ),
                          SizedBox(
                            height: mediaquery.height * .01,
                          ),
                          TextfieldflormWidget(
                            onTap: () async {
                              await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  endtimeController.text =
                                      value.format(context);
                                }
                              });
                            },
                            controller: endtimeController,
                            readOnly: true,
                            isobsecure: false,
                            suffixIcon: const Icon(
                              Icons.access_time,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: mediaquery.height * .02,
                ),

                /////////////////////////////////////////////////circleAvatar for color

                Row(
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: index == 0
                                  ? AppColors.primaryColor
                                  : index == 1
                                      ? Colors.orange
                                      : Colors.red,
                              child: (selectedColor == index)
                                  ? const Icon(
                                      Icons.check,
                                      color: AppColors.whiteColor,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        );
                      }),
                    ),
                    Spacer(),
                    SizedBox(
                      height: mediaquery.height * .07,
                      width: mediaquery.width * .35,
                      child: CustomButton(
                        text: widget.taskmodel?.id == null
                            ? "Add Task"
                            : "Update Task",
                        onPressed: () {
                          if ((formKey.currentState as FormState).validate()) {
                            //update with id
                            if (widget.taskmodel?.id == null) {
                              String id = DateTime.now().toString() +
                                  titleController.text;

                              AppLocalStorage.cachedTaskData(
                                id,
                                TaskMdel(
                                    id: id,
                                    title: titleController.text,
                                    note: noteController.text,
                                    date: dateController.text,
                                    startTime: starttimeController.text,
                                    endTime: endtimeController.text,
                                    color: selectedColor,
                                    isCompleted: false),
                              );
                            } else {
                              String id = widget.taskmodel!.id;
                              AppLocalStorage.cachedTaskData(
                                id,
                                TaskMdel(
                                    id: id,
                                    title: titleController.text,
                                    note: noteController.text,
                                    date: dateController.text,
                                    startTime: starttimeController.text,
                                    endTime: endtimeController.text,
                                    color: selectedColor,
                                    isCompleted: false),
                              );
                            }

                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
