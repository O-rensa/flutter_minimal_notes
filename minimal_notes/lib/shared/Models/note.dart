import "package:isar/isar.dart";

part "note.g.dart"; // this line is needed to generate file
// run on cmd => dart run build_runner build

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}