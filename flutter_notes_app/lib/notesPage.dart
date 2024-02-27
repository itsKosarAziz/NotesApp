import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class notesPage extends StatefulWidget {
  const notesPage({super.key});
  @override
  State<notesPage> createState() => _notesPageState();
}

class _notesPageState extends State<notesPage> {
  List _notes = [];
  Future<void> getNotes() async {
    final String notesResponse =
        await rootBundle.loadString('assets/notes.json');
    final notesData = await json.decode(notesResponse);
    setState(() {
      _notes = notesData["notes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    getNotes();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes App'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Expanded(
            child: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return Card(
                key: ValueKey(_notes[index]["id"]),
                child: ListTile(
                  leading: Text(_notes[index]["title"]),
                  title: Text(_notes[index]["description"]),
                ));
          },
        )));
  }
}
