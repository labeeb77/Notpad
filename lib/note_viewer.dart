import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:note_app/styles.dart';
import 'package:note_app/utils.dart';

import 'edit_note.dart';

class NoteViewer extends StatefulWidget {
  NoteViewer({super.key, required this.doc});
  final QueryDocumentSnapshot? doc;
  @override
  State<NoteViewer> createState() => _NoteViewerState();
}

class _NoteViewerState extends State<NoteViewer> {
  @override
  Widget build(BuildContext context) {
    final int colorId = int.parse(widget.doc!["color_id"]);
    final DateTime creationDate = DateTime.parse(widget.doc!["creation_date"]);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Note App"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppStyle.cardColor[colorId],
        ),
        backgroundColor: AppStyle.cardColor[colorId],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doc!["note_title"],
                  style: AppStyle.mainTitle,
                ),
                Text(
                  Utils.formatDate(creationDate),
                  style: AppStyle.dateTitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.doc!["note_content"],
                  style: AppStyle.mainContent,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          renderOverlay: false,
          animatedIcon: AnimatedIcons.menu_home,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.edit),
                label: 'Edit',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNote(
                          doc: widget.doc,
                          title: widget.doc!["note_title"],
                          content: widget.doc!["note_content"],
                        ),
                      ));
                }),
            SpeedDialChild(
                child: const Icon(Icons.delete),
                label: 'Delete',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Deletion"),
                        content: const Text(
                            "Are you sure you want to delete this note?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteNoteFromFirebase(widget.doc!.id);
                              // Provide the document ID of the note
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ],
        ));
  }

  // Delete a Note from firebase

  void deleteNoteFromFirebase(
    String docId,
  ) async {
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference noteRef = firestore.collection('notes');

    try {
      await noteRef.doc(docId).delete();
      Navigator.pop(context);
      Navigator.pop(context);
      log("Note deleted successfully");
    } catch (e) {
      log(e.toString());
    }
  }
}
