import 'package:bookmarker/models/bookmark_model.dart';
import 'package:bookmarker/models/data/database.dart';
import 'package:drift/drift.dart';

class Bookmarkmapper {
  static BookmarksCompanion toCompanion(BookmarkData bookmark){
    return BookmarksCompanion(      
      title: Value(bookmark.title),
      imageURL: Value(bookmark.imageUrl),
      hostURL: Value(bookmark.hostUrl),
      addedDate: Value(bookmark.addedDate),
      link: Value(bookmark.link),
      uuid: Value(bookmark.uuid!)
    );
  }
}