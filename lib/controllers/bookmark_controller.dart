import 'package:bookmarker/models/data/database.dart';
import 'package:bookmarker/models/bookmark_model.dart';
import 'package:bookmarker/service/bookmark_service.dart';
import 'package:bookmarker/utils/SharedPrefHelper.dart';
import 'package:bookmarker/utils/bookmarkMapper.dart';

class BookmarkController {
  final BookmarkService _bookmarkService;
  BookmarkController(this._bookmarkService);

  Future<int> addBookmark(BookmarksCompanion bookmark) async {
    Sharedprefhelper.setHasDataToSync(true);
    return await _bookmarkService.addBookmark(bookmark);
  }

  Stream<List<Bookmark>> getAllBookmarksStream() {
    return _bookmarkService.getBookmarksStream();
  }
  Future<int> insertOrUpdateBookmark(BookmarksCompanion bookmark) async {

    return await _bookmarkService.insertOrUpdateBookmark(bookmark);
  }
  Future<List<Bookmark>> getBookmarks() async {
    return await _bookmarkService.getBookmarks();
  }
  Future<void> deleteBookmark(String uuid) async {
    Sharedprefhelper.setHasDataToSync(true);
    await _bookmarkService.deleteBookmark(uuid);
  }

  Future<void> insertBookmarkDataList(List<BookmarkData> bookmarkData) async {    
    for(var data in bookmarkData){
      final BookmarksCompanion = Bookmarkmapper.toCompanion(data);
      await insertOrUpdateBookmark(BookmarksCompanion);
    }
  }
}