import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String currentText;
  final void Function(String)? onSubmitted;

  const SearchBar({super.key, this.onSubmitted, this.currentText = ""});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.currentText;
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
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () => widget.onSubmitted?.call(_controller.text),
            child: const Icon(Icons.search_rounded, size: 32),
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