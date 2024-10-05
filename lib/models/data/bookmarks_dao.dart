import 'package:bookmarker/models/data/bookmarks_table.dart';
import 'package:bookmarker/models/data/database.dart';
import 'package:drift/drift.dart';

part 'bookmarks_dao.g.dart';
@DriftAccessor(tables: [Bookmarks])
class BookmarksDao extends DatabaseAccessor<AppDatabase> with _$BookmarksDaoMixin{
  BookmarksDao(super.attachedDatabase);

    Stream<List<Bookmark>> getAllBookmarksStream() {
    return select(bookmarks).watch();
  }

  // Get all bookmarks as a list
  Future<List<Bookmark>> getAllBookmarksList() async {
    return await select(bookmarks).get();
  }

  // Insert a new bookmark
  Future<int> insertBookmark(BookmarksCompanion entity) async {
    return await into(bookmarks).insert(entity);
  }

  // Insert or update a bookmark on conflict
  Future<int> insertOrUpdateBookmark(BookmarksCompanion entity) async {
    return await into(bookmarks).insertOnConflictUpdate(entity);
  }

  // Delete a bookmark by ID
  Future<void> deleteBookmarkByUUID(String uuid) async {
    await (delete(bookmarks)..where((tbl) => tbl.uuid.equals(uuid))).go();
  }


}