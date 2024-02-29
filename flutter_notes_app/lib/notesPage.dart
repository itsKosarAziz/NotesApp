import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class notesPage extends StatefulWidget {
  const notesPage({super.key});
  @override
  State<notesPage> createState() => _notesPageState();
}

class _notesPageState extends State<notesPage> {
  final StreamController<List<dynamic>> _notesStreamController =
      StreamController<List<dynamic>>();
  bool loadingNotes = true;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future<void> getNotes() async {
    try {
      final String notesResponse =
          await rootBundle.loadString('assets/notes.json');
      final List<dynamic> notesData = json.decode(notesResponse)['notes'];
      _notesStreamController.add(notesData);
    } catch (e) {
      _notesStreamController.addError('Could not load notes');
    } finally {
      setState(() {
        loadingNotes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes App'),
          backgroundColor: Colors.deepPurple,
        ),
        body: StreamBuilder<List<dynamic>>(
            stream: _notesStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else if (snapshot.hasData) {
                final List<dynamic> notes = snapshot.data!;
                if (notes.isNotEmpty) {
                  return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          key: ValueKey(notes[index]["id"]),
                          child: ListTile(
                            leading: Text(notes[index]["title"]),
                            title: Text(notes[index]["description"]),
                          ),
                        );
                      });
                } else {
                  return Center(
                      child: Text(
                          'No notes to load, please add a note to the file'));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  @override
  void dispose() {
    _notesStreamController.close();
    super.dispose();
  }
}
