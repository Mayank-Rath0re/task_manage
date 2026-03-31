import 'package:flutter/material.dart';

class AbsTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function()? onChanged;
  const AbsTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  State<AbsTextfield> createState() => _AbsTextfieldState();
}

class _AbsTextfieldState extends State<AbsTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
