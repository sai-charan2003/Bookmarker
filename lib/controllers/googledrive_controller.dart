import 'package:bookmarker/models/data/database.dart';
import 'package:bookmarker/models/bookmark_model.dart';
import 'package:bookmarker/service/bookmark_service.dart';
import 'package:bookmarker/service/googledrive_backup_service.dart';
import 'package:bookmarker/service/googledrive_service.dart';
import 'package:bookmarker/utils/SharedPrefHelper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogledriveController {
 
  final GoogleDriveService _googleDriveService;
  final GoogledriveBackupService _googledriveBackupService;
  final BookmarkService _bookmarkService;
  GoogledriveController(this._googleDriveService,this._googledriveBackupService,this._bookmarkService);

  Future<GoogleSignInAccount?> getCurrentUserDetails(){
    return _googleDriveService.getCurrentUserDetails();
  }

  Future<GoogleSignInAccount?> googleSignIn(){
    return _googleDriveService.google_sign_in();
  }

  Future<bool> googleSignOut(){
    return _googleDriveService.google_sign_out();
  }

  Future<bool> backupData(drive.DriveApi driveApi,List<Bookmark> localData) async{  
    var result = false;
    
    result = await _googledriveBackupService.backupData(driveApi,localData);
    
    return result;

  }

  Future<List<BookmarkData>?> getBackupData(drive.DriveApi driveApi){
    return _googledriveBackupService.getBackupData(driveApi);
  }

  Future<drive.DriveApi?> getDriveAPIClient(GoogleSignInAccount? currentUser){
    return _googleDriveService.getDriveAPIClient(currentUser);
  }

  Future<List<BookmarkData>?> startSync() async {
    print(Sharedprefhelper.getHasDataToSync());
    
    final current_user = await getCurrentUserDetails();
    List<BookmarkData>? _bookmarkData;
    if(current_user!=null){
    final driveAPI = await getDriveAPIClient(current_user);
    final localData = await  _bookmarkService.getBookmarks();
    if(Sharedprefhelper.getHasDataToSync()==true){
      print("Sync starting...");
        await backupData(driveAPI!, localData);
    }
    _bookmarkData = await getBackupData(driveAPI!); 
    }
    return _bookmarkData;

  }

}