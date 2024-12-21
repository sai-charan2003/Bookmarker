import 'dart:convert';

import 'package:bookmarker/models/data/database.dart';
import 'package:bookmarker/models/bookmark_model.dart';
import 'package:bookmarker/utils/SharedPrefHelper.dart';
import 'package:googleapis/drive/v3.dart' as drive;


class GoogledriveBackupService {
   static const _googleDriveBackupFile = "bookmarkBackupv1.json";
  Future<bool> backupData(drive.DriveApi driveApi, List<Bookmark> localData) async {
      try {       

        List<Map<String, dynamic>> jsonDataList = localData.map((bookmark) => bookmark.toJson()).toList();

        String jsonData = jsonEncode(jsonDataList);

        List<int> jsonDataBytes = utf8.encode(jsonData);
        
        var driveFile = drive.File();
        driveFile.name = _googleDriveBackupFile;
        driveFile.modifiedTime = DateTime.now();
        driveFile.parents = ["appDataFolder"];

        var uploadedFile = await driveApi.files.create(
          driveFile,
          uploadMedia: drive.Media(Stream.value(jsonDataBytes), jsonDataBytes.length),
        );
        Sharedprefhelper.setLastSyncedTime(DateTime.now().millisecondsSinceEpoch.toString());
        Sharedprefhelper.setHasDataToSync(false);        
        print("Data uploaded successfully, File ID: ${uploadedFile.id}");
        return true;
            } catch (e) {
        print("Error while uploading data: $e");
        return false;
      }
    }

  Future<List<BookmarkData>?> getBackupData(drive.DriveApi driveApi) async{
  try{  
    var driveFile = drive.File();
    driveFile.name = _googleDriveBackupFile;
    driveFile.modifiedTime = DateTime.now();
    driveFile.parents = ["appDataFolder"];
    var data =await driveApi.files.list(
      spaces: 'appDataFolder',
      q: "name = '$_googleDriveBackupFile'",
      $fields: 'files(id,name)',
    );
    if(data.files !=null && data.files!.isNotEmpty){
      var fileId = data.files?.first.id;
      dynamic file = await driveApi.files.get(fileId!, downloadOptions: drive.DownloadOptions.fullMedia);
      List<int> dataStore = [];
      await for (var data in file.stream){
        dataStore.insertAll(dataStore.length, data);

      }
      String jsonData = utf8.decode(dataStore);
      var bookmarkData = bookmarkDataFromJson(jsonData);
 
      print(jsonData);
      return bookmarkData;
      


    }
  } catch(e){
    print("error while uploading data $e");
    return null;

  }
  return null;
}
}