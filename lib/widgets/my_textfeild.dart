import 'package:flutter/material.dart';

class MyTextfeild extends StatefulWidget {
  const MyTextfeild({super.key, required this.textcontroller});
  final TextEditingController? textcontroller;

  @override
  State<MyTextfeild> createState() => _MyTextfeildState();
}

class _MyTextfeildState extends State<MyTextfeild> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textcontroller,
      maxLines: 4,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Encrypted/Decrypted message will appear here...',
        filled: true,
        fillColor: Colors.green.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
