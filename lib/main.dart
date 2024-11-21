// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/services/dio_provider.dart';
import 'package:islami/features/hadeth/presentation/bloc/hadith_time_bloc.dart';
import 'package:islami/features/intro/splash/presentation/views/splash_screen.dart';
import 'package:islami/features/prayerTime/presentation/bloc/azkar_bloc.dart';
import 'package:islami/features/quran/presentation/bloc/quran_time_bloc.dart';
import 'package:islami/features/today_werd/data/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive db
  await Hive.initFlutter();
  //create or open a box(table name)...
  await Hive.openBox('user');
  //type adapter generator
  Hive.registerAdapter(TaskMdelAdapter());
  //create box for task table
  await Hive.openBox<TaskMdel>("task");
  //////////////////////create box for sebha
  await Hive.openBox('sebha');
  //initialize app
  await AppLocalStorage.init();

  ///////dio prrovider
  await DioProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HadithTimeBloc(),
        ),
        BlocProvider(
          create: (context) => QuranTimeBloc(),
        ),
        BlocProvider(create: (context) => AzkarBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Islami zaker App',
        home: SplashScreen(),
      ),
    );
  }
}
//
