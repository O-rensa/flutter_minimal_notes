import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimal_notes/shared/Models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE - DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
      [NoteSchema], 
      directory: dir.path,
    );
  }

  // list of notes
  final List<Note> currentNotes = [];

  // CREATE 
  Future<void> createNote(String text) async {
    final newNote = Note()..text = text;

    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    // re-read from db
    getAllNotes();
  }

  // READ
  Future<void> getAllNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // UPDATE
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
    } else {
      await createNote(newText);
    }
    await getAllNotes();
  }

  // DELETE
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await getAllNotes();
  }
}