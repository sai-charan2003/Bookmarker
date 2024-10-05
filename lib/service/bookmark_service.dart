import 'package:bookmarker/models/data/bookmarks_dao.dart';

import '../models/data/database.dart';

class BookmarkService {
  final BookmarksDao _bookmarksDao;
  BookmarkService(this._bookmarksDao);
    Future<int> addBookmark(BookmarksCompanion bookmark) async {
    return await _bookmarksDao.insertBookmark(bookmark);
  }

 
  Future<List<Bookmark>> getBookmarks() async {
    return await _bookmarksDao.getAllBookmarksList();
  }

  
  Stream<List<Bookmark>> getBookmarksStream() {
    return _bookmarksDao.getAllBookmarksStream();
  }


  Future<int> insertOrUpdateBookmark(BookmarksCompanion bookmark) async {
    return await _bookmarksDao.insertOrUpdateBookmark(bookmark);
  }


  Future<void> deleteBookmark(String uuid) async {
    await _bookmarksDao.deleteBookmarkByUUID(uuid);
  }


}