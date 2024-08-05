import "package:flutter/material.dart";

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
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
        )
      );
    }

    // read notes

    // update a note

    // delete a note

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: const Text(
          "Notes"
          ),
      ),

      // add note button
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNote(),

        child: const Icon(Icons.add),
      ),

    );
  }
}