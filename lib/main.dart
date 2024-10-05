import 'dart:core';
import 'package:bookmarker/controllers/bookmark_controller.dart';
import 'package:bookmarker/controllers/googledrive_controller.dart';
import 'package:bookmarker/models/data/bookmarks_dao.dart';
import 'package:bookmarker/models/data/database.dart';
import 'package:bookmarker/firebase_options.dart';
import 'package:bookmarker/ui/homeScreen.dart';
import 'package:bookmarker/service/bookmark_service.dart';
import 'package:bookmarker/service/googledrive_backup_service.dart';
import 'package:bookmarker/service/googledrive_service.dart';
import 'package:bookmarker/ui/theme.dart';
import 'package:bookmarker/utils/SharedPrefHelper.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Sharedprefhelper.init();
  Get.put(AppDatabase());
  Get.put(BookmarksDao(Get.find<AppDatabase>()));
  Get.put(BookmarkService(Get.find<BookmarksDao>()));
  Get.put(GoogledriveController(GoogleDriveService(), GoogledriveBackupService(),Get.find<BookmarkService>()));
  Get.put(BookmarkController(Get.find<BookmarkService>()));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget { 
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {  
    
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme){
      return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme ?? MaterialTheme.lightScheme(),
            useMaterial3: true
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme?? MaterialTheme.darkScheme(),
            useMaterial3: true
          ),
          home: const  Homescreen(),
        
      );
    });
  }
}








