import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/shared_preference.dart';
import '../services/notes_model.dart';

class NotesPage extends StatefulWidget {
  static const String id = "notes_page";

  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool isLoading = true;
  List<Note> listofNotes = [];
  TextEditingController noteController = TextEditingController();

  void _createNotes() async {
    String text = noteController.text.toString().trim();
    listofNotes.add(Note(
        date: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.now().hour,
          DateTime.now().minute,
        ).toString().substring(0, 16),
        notes: text));
    loadList();
  }
  Future<void> loadList() async {
    String notes = Note.encode(listofNotes);
    Prefs.storeNotes(notes);
    listofNotes = Note.decode(await Prefs.loadNotes() as String);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(milliseconds: 500),
        () => setState(() {
              isLoading = false;
            }));
    loadList();
  }

  void _androidDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
            title: const Text(
              "New Note",
              style: TextStyle(color: Colors.greenAccent),
            ),
            content: TextField(
              controller: noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: "Enter your note!",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    _createNotes();
                    Navigator.pop(context);
                    noteController.clear();
                    setState(() {});
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.blueAccent.shade400,
        title: const Text("Notes"),
      ),
      body: listofNotes.isEmpty
          ? Center(
              child: isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text(
                      "There are not any notes",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
            )
          : ListView.builder(
              itemCount: listofNotes.length,
              itemBuilder: (context, index) {
                return _notes(index);
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: _androidDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _notes(int index) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          onPressed: (BuildContext context) {
            listofNotes.removeAt(index);
            loadList();
            setState(() {});
          },
          icon: Icons.delete,),
        SlidableAction(
          backgroundColor: Colors.blue,
          onPressed: (BuildContext context) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
                    title: const Text(
                      "New Note",
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                    content: TextField(
                      controller: noteController..text = listofNotes[index].notes!,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "Enter your note!",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                          )),
                      TextButton(
                          onPressed: () {
                            listofNotes[index].notes = noteController.text;
                            loadList();
                            Navigator.pop(context);
                            noteController.clear();
                            setState(() {});
                          },
                          child: const Text(
                            "SAVE",
                            style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                          )),
                    ],
                  );
                });
          },
          icon: Icons.edit),
      ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  size: 12,
                  color: Colors.transparent,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(listofNotes[index].date!),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                  child: Icon(
                    Icons.circle,
                    size: 12,
                    color: Colors.greenAccent,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 52,
                    child: Text(
                      listofNotes[index].notes!,
                      style: const TextStyle(fontSize: 20),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
