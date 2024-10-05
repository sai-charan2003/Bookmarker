import 'package:bookmarker/controllers/bookmark_controller.dart';
import 'package:bookmarker/ui/bookmarkAddedScreen.dart';
import 'package:bookmarker/utils/AppUtils.dart';
import 'package:bookmarker/models/data/database.dart';
import 'package:bookmarker/utils/extractWebsiteContent.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../controllers/googledrive_controller.dart';

void showAddBookmarkBottomSheet(BuildContext context, String? url) {
  final TextEditingController urlTextEditingController = TextEditingController();
  final BookmarkController bookmarkController = Get.find<BookmarkController>();
  final GoogledriveController googledriveController = Get.find<GoogledriveController>();

  var isLoading = false.obs;
  var isNotValidLink = false.obs;
  var isButtonEnabled = false.obs;
  var uuid = const Uuid();

  urlTextEditingController.addListener(() {
    isButtonEnabled.value = urlTextEditingController.text.isNotEmpty;
  });

  Future<void> saveBookmark() async {
    if (!AppUtils().isLinkValid(urlTextEditingController.text)) {
      isNotValidLink.value = true;
      return;
    }

    isNotValidLink.value = false;
    isLoading.value = true;
    isButtonEnabled.value = false;

    var websiteData = await extractWebsiteData(urlTextEditingController.text);
    if (websiteData != null) {
      bookmarkController.addBookmark(BookmarksCompanion(
        link: drift.Value(urlTextEditingController.text),
        imageURL: drift.Value(websiteData.imageUrl),
        title: drift.Value(websiteData.title),
        addedDate: drift.Value(DateTime.now().microsecondsSinceEpoch.toString()),
        hostURL: drift.Value(websiteData.hostURL),
        uuid: drift.Value(uuid.v1())
      ));

      HapticFeedback.heavyImpact();
      googledriveController.startSync(); 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bookmark added"),
        behavior: SnackBarBehavior.floating,
      ));
      if(url ==null){
      Navigator.pop(context);
      } else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Bookmarkaddedscreen()));
      }
    } else {
      isNotValidLink.value = true;
    }
    isLoading.value = false;
    isButtonEnabled.value = true;
  }

  if (url != null) {
    urlTextEditingController.text = url;
    saveBookmark();
  }

  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Add Bookmark",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22.0, left: 16, right: 16),
              child: Obx(() {
                return TextFormField(
                  controller: urlTextEditingController,
                  autofocus: true,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => saveBookmark(),
                  decoration: InputDecoration(
                    hintText: "https://www.example.com",
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w200),
                    border: const OutlineInputBorder(),
                    errorText: isNotValidLink.value ? "Enter a valid URL" : null,
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                return FilledButton(
                  onPressed: isButtonEnabled.value && !isLoading.value ? saveBookmark : null,
                  style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading.value)
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(strokeWidth: 3, strokeCap: StrokeCap.round)),
                        ),
                      const Text("Bookmark"),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    },
  );
}
