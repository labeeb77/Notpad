import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/add_note.dart';
import 'package:note_app/note_card.dart';
import 'package:note_app/note_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recent Notes",
                  style: GoogleFonts.roboto(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("notes")
                    .orderBy("creation_date", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final note = snapshot.data!.docs[index];
                        return noteCard(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteViewer(doc: note),
                              ));
                        }, note);
                      },
                    );
                  }
                  return Text(
                    "no notes",
                    style: GoogleFonts.nunito(),
                  );
                },
              )
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNote(),
              ));
        },
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
