import 'package:flutter/material.dart';

class StyledField extends StatelessWidget {
  const StyledField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final void Function(String? value) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      elevation: 15,
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: icon,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        onFieldSubmitted: onSubmit,
      ),
    );
  }
}
