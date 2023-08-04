import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/styles.dart';

import 'circle_color.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Color selectedColor = AppStyle.cardColor[1];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleColor(
                    color: AppStyle.cardColor[1],
                    isSelected: selectedColor == AppStyle.cardColor[1],
                    onTap: () {
                      setState(() {
                        selectedColor = AppStyle.cardColor[1];
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  CircleColor(
                    color: AppStyle.cardColor[2],
                    isSelected: selectedColor == AppStyle.cardColor[2],
                    onTap: () {
                      setState(() {
                        selectedColor = AppStyle.cardColor[2];
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  CircleColor(
                    color: AppStyle.cardColor[3],
                    isSelected: selectedColor == AppStyle.cardColor[3],
                    onTap: () {
                      setState(() {
                        selectedColor = AppStyle.cardColor[3];
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  CircleColor(
                    color: AppStyle.cardColor[4],
                    isSelected: selectedColor == AppStyle.cardColor[4],
                    onTap: () {
                      setState(() {
                        selectedColor = AppStyle.cardColor[4];
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  CircleColor(
                    color: AppStyle.cardColor[5],
                    isSelected: selectedColor == AppStyle.cardColor[5],
                    onTap: () {
                      setState(() {
                        selectedColor = AppStyle.cardColor[5];
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  CircleColor(
                    color: AppStyle.cardColor[6],
                    isSelected: selectedColor == AppStyle.cardColor[6],
                    onTap: () {
                      setState(() {
                        selectedColor = AppStyle.cardColor[6];
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      addNoteToFirebase(titleController.text,
                          contentController.text, selectedColor);
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Save")),
              )
            ],
          ),
        ),
      )),
    );
  }

  //add New notes to firbase

  void addNoteToFirebase(String title, String content, Color color) async {
    setState(() {
      isLoading = true;
    });
    await Firebase.initializeApp();

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference noteRef = firestore.collection('notes');

    try {
      Map<String, dynamic> newNote = {
        'note_title': title,
        'note_content': content,
        'color_id': AppStyle.cardColor.indexOf(color).toString(),
        'creation_date': DateTime.now().toString(),
      };

      await noteRef.add(newNote);
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      log("note added successfully");
    } catch (e) {
      log(e.toString());
    }
  }
}
