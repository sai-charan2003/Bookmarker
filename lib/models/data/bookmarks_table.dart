import 'package:drift/drift.dart';

class Bookmarks extends Table {
  TextColumn get link => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get addedDate => text().nullable()();
  TextColumn get imageURL => text().nullable()();
  TextColumn get hostURL => text().nullable()(); 
  TextColumn get uuid => text()();
  @override
 
  Set<Column<Object>>? get primaryKey => {uuid};
  
}