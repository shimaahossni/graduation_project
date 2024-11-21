// core/services/app_local_storage.dart
import 'package:hive/hive.dart';
import 'package:islami/features/today_werd/data/task_model.dart';

class AppLocalStorage {
  static late Box userBox;
  static late Box<TaskMdel> taskBox;
  static late Box sebhaBox;
  static String nameKey = "nameKey";
  static String imageKey = "imageKey";
  static String sebhaKey = "sebhakey";
  static String isUpload = "isUploadKey";

  static init() {
    userBox = Hive.box('user');
    taskBox = Hive.box<TaskMdel>('task');
    sebhaBox = Hive.box('sebha');
  }

//////////////////////////////////////////////////////////////////////user box functions
  static cachedData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getCachedData(String key) {
    return userBox.get(key);
  }

  //////////////////////////////////////////////////////////////////////task box functions
  static cachedTaskData(String key, TaskMdel value) {
    taskBox.put(key, value);
  }

  static TaskMdel? getCachedTaskData(String key) {
    return taskBox.get(key);
  }

  //////////////////////////////////////////////////////////////////seha box functions
  static cachedSebhaData(String key, dynamic value) {
    sebhaBox.put(key, value);
  }

  static getCachedSebhaData(String key) {
    return sebhaBox.get(key);
  }
}
