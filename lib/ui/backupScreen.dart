
import 'package:bookmarker/controllers/googledrive_controller.dart';
import 'package:bookmarker/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import '../controllers/bookmark_controller.dart';
import '../utils/SharedPrefHelper.dart';

class Backupscreen extends StatefulWidget {
  const Backupscreen({super.key});

  @override
  State<Backupscreen> createState() => _BackupscreenState();
}

class _BackupscreenState extends State<Backupscreen> {
  var isDriveEnabled = false.obs;
  var isLoading = true.obs;
  var lastSynced = ''.obs;
  drive.DriveApi? driveApi;
  GoogleSignInAccount? currentAccount;
  final GoogledriveController _googledriveController = Get.find<GoogledriveController>();
  final BookmarkController _bookmarkController = Get.find<BookmarkController>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

Future<void> _initialize() async {
  isLoading.value = true;
  await _signInStatus();
  last_updated();
  isLoading.value = false;
}

Future<void> _signInStatus() async {    
  currentAccount = await _googledriveController.getCurrentUserDetails();
  isDriveEnabled.value = currentAccount != null;
  print(currentAccount);
}

Future<void> _toggleDriveSync() async {
  isLoading.value = true;
  if (!isDriveEnabled.value) {
    currentAccount = await _googledriveController.googleSignIn();
    driveApi = await _googledriveController.getDriveAPIClient(currentAccount);
    if (driveApi != null) {
      final bookmarkData = await _googledriveController.getBackupData(driveApi!);
      if (bookmarkData != null) {
        await _bookmarkController.insertBookmarkDataList(bookmarkData);
      }
      await _googledriveController.backupData(driveApi!, await _bookmarkController.getBookmarks());
      isDriveEnabled.value = true;

    }
  } else {
    final isSuccess = await _googledriveController.googleSignOut();
    if (isSuccess) {
      isDriveEnabled.value = false;
    }
  }
  last_updated();
  isLoading.value = false;
}
Future<void> last_updated() async {
  lastSynced.value = AppUtils().timeMillisToDateConverter(Sharedprefhelper.getLastSyncedTime());
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text("Backup"),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Obx(()=>
                ListTile(
                  title: const Text("Google Drive sync"),
                  trailing: Switch(
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                        (Set<WidgetState> states) {
                      if (isLoading.value) {
                        return const Icon(Icons.sync); 
                      } else if (isDriveEnabled.value) {
                        return const Icon(Icons.done);
                      } else {
                        return const Icon(Icons.cloud_off);
                      }
                    }),
                    value: isDriveEnabled.value,
                    onChanged: !isLoading.value ? (bool value) async {
                      await _toggleDriveSync();
                    } : null,
                  ),
                )),
                Obx(
                  () {
                    return ListTile(
                      title: const Text("Last synced"),
                      subtitle: Text(lastSynced.value),
                    );
                  }
                ),
                Obx(
                  () {
                    return ListTile(
                      title: const Text("Google account"),
                      subtitle: isLoading.value? const Text("Loading ...."):Text(currentAccount?.email ?? 'Sign in'),
                    
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
