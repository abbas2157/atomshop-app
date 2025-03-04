import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onClear;
  final bool readOnly;
  final Function(String)? onSearch;
  final Function()? onTap;

  const SearchTextField(
      {super.key,
      required this.controller,
      this.onClear,
      this.onSearch,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: TextField(
        onTap: onTap,
        readOnly: readOnly,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus(); // Unfocus on tap outside
        },
        controller: controller,
        onChanged: onSearch,
        cursorColor: Colors.grey.shade700, // Subtle grey cursor
        style:
            TextStyle(fontSize: 16, color: Colors.grey.shade900), // Darker text
        decoration: InputDecoration(
          hintText: "what are you looking for?",
          hintStyle: TextStyle(color: Colors.grey.shade400), // Softer grey hint
          prefixIcon: Icon(Icons.search,
              color: Colors.grey.shade500), // Elegant grey icon
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: onClear ??
                      () {
                        controller.clear();
                        if (onSearch != null) onSearch!('');
                      },
                  child: Icon(Icons.cancel,
                      color: Colors.grey.shade500), // Softer cancel icon
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade300, // Subtle grey background
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none, // No hard borders
          ),
        ),
      ),
    );
  }
}
