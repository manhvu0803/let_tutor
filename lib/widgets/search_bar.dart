import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String)? onSubmitted;

  const SearchBar({super.key, this.onSubmitted});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  void _submit() {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: widget.onSubmitted,
            decoration: const InputDecoration(
              labelText: "Search",
              hintText: "Course name...",
              hintStyle: TextStyle(fontStyle: FontStyle.italic),
              border: OutlineInputBorder()
            ),
          ),
        ),
        GestureDetector(
          onTap: _submit,
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.search_rounded, size: 32),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}