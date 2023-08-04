import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/styles.dart';

class EditNote extends StatefulWidget {
  final QueryDocumentSnapshot? doc;
  const EditNote(
      {super.key,
      required this.doc,
      required this.title,
      required this.content});
  final String title;
  final String content;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title;
    contentController.text = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int colorId = int.parse(widget.doc!["color_id"]);
    return Scaffold(
      backgroundColor: AppStyle.cardColor[colorId],
      appBar: AppBar(
        title: const Text("Edit Note"),
        centerTitle: true,
        backgroundColor: AppStyle.cardColor[colorId],
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Note title',
                  labelStyle: const TextStyle(
                    color: Colors.white, // Set the label text color here
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: contentController,
              maxLines: 4,
              decoration: InputDecoration(
                  labelText: 'Note Content',
                  labelStyle: const TextStyle(
                      color: Colors.white // Set the label text color here
                      ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 300,
              height: 40,
              child: ElevatedButton(onPressed: () {
                updateNoteInFireBase();
                Navigator.pop(context);
              }, child: const Text("Save")),
            )
          ],
        ),
      )),
    );
  }

  // update note to firebase

  void updateNoteInFireBase() async {
    await Firebase.initializeApp();

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference noteRef =
        firestore.collection('notes').doc(widget.doc!.id);
    Map<String, dynamic> updatedNote = {
      'note_title': titleController.text,
      'note_content': contentController.text,
    };

    await noteRef.update(updatedNote);
    log('Note updated successfully');
  }
}
