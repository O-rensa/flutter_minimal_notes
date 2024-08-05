import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:minimal_notes/shared/Models/note.dart";
import "package:minimal_notes/shared/Models/note_database.dart";
import "package:minimal_notes/shared/components/my_drawer.dart";
import "package:provider/provider.dart";

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
    @override
  void initState() {
    super.initState();

    // on start up read all notes
    readNotes();
  }

  // textfield controller
  final TextEditingController textController = TextEditingController();

  // create a note
  void createNote() {
    showDialog(
      context: context,
  
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          // create button
          MaterialButton(
            onPressed: () {
              // add to db
              context.read<NoteDatabase>().createNote(textController.text);
  
              //clear the text controller
              textController.clear();
  
              // pop the dialog
              Navigator.pop(context);
            },
  
            child: const Text("Create"),
          )
        ],
      )
    );
  }
  
  // read notes
  void readNotes() {
    context.read<NoteDatabase>().getAllNotes();
  }
  
  // update a note
  void updateNote(Note note) {
    // pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          // update button
          MaterialButton(
            onPressed: () {
              context.read<NoteDatabase>().updateNote(note.id, textController.text);
              // cler controller
              textController.clear();
              // pop dialog
              Navigator.pop(context);
            },

            child: const Text("Update"),
          )
        ],
      ),
    );
  }
  
  // delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNotes =  noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),

      drawer: const MyDrawer(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // list of notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                  // get individual note
                  final note = currentNotes[index];
            
                  // list tile UI
                  return ListTile(
                    title: Text(
                      note.text,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                  
                      children: [
                        // edit button
                        IconButton(
                          onPressed: () => updateNote(note),
                          icon: const Icon(Icons.edit),
                        ),
                  
                        // delete button
                        IconButton(
                          onPressed: () => deleteNote(note.id),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                }
              ),
          ),
        ],
      ),

      // add note button
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNote(),

        child: const Icon(Icons.add),
      ),

    );
  }
}