import 'package:flutter/material.dart';

class DataInputField extends StatefulWidget {
  const DataInputField({
    Key? key,
    required this.controller,
    required this.inputType,
    this.onSubmitted,
  }) : super(key: key);
  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String)? onSubmitted;

  @override
  State<DataInputField> createState() => _DataInputFieldState();
}

class _DataInputFieldState extends State<DataInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: TextField(
        controller: widget.controller,
        maxLines: 1,
        keyboardType: widget.inputType,
        textAlign: TextAlign.right,
        onSubmitted: widget.onSubmitted,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
