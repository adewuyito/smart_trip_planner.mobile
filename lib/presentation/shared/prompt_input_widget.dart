import 'package:flutter/material.dart';

class NoteInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const NoteInputField({super.key, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 171,
      child: Scrollbar(
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null, // allows multiple lines
          expands: true, // makes it fill the fixed height
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: hintText ?? 'Write your note...',
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.green, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.green, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
