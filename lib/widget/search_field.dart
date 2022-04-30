import 'package:flutter/material.dart';


class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;

  const SearchField({Key? key, this.autofocus, this.focusNode, this.controller})
      : super(key: key);

  @override
  _SearchField createState() => _SearchField();
}

class _SearchField extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        cursorColor: Colors.deepOrange,
        decoration: const InputDecoration(
          hintText: 'Cari Restaurant ... ',
          prefixIcon: Icon(Icons.search, color: Colors.black),
        ),
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus != null ? widget.autofocus! : false,
        textAlign: TextAlign.left,
      ),
    );
  }
}