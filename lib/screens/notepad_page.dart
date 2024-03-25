import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:periods/themes/text_styles.dart';

class NotepadPage extends StatefulWidget {
  const NotepadPage({super.key});

  @override
  State<NotepadPage> createState() => _NotepadPageState();
}

class _NotepadPageState extends State<NotepadPage> {
  TextEditingController notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Notes',
              style: bold.copyWith(
                fontSize: 28,
                color: const Color(
                  0xFF12175E,
                ),
              ),
            ),
            Text(
              'Write down your homework here',
              style: regularFont.copyWith(
                fontSize: 16,
                color: const Color(
                  0xFF575757,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: notesController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14),
                ),
                hintText: "Enter homework here...",
                hintStyle: medium.copyWith(
                  color: Colors.grey[400],
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveNotes(String text) async {
    var box = Hive.box('userSettings');
    await box.put('notes', text);
  }
}
