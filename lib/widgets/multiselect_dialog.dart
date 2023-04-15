import 'package:flutter/material.dart';
import 'package:let_tutor/utils/iterable_extension.dart';

class MultiselectDialog<T> extends StatefulWidget {
  final Map<T, bool> options;

  const MultiselectDialog({super.key, required this.options});

  @override
  State<StatefulWidget> createState() => _MultiselectDialogState<T>();
}

class _MultiselectDialogState<T> extends State<MultiselectDialog<T>> {
  late final Map<T, bool> _options;

  Set<T> get _selectedOptions {
    final set = <T>{};

    for (final option in _options.keys) {
      if (_options[option] ?? false) {
        set.add(option);
      }
    }

    return set;
  }

  @override
  void initState() {
    super.initState();
    _options = Map.from(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 480,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 400,
                child: ListView(
                  children: widget.options.keys.toNewList(
                    (option) => CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _options[option],
                      onChanged: (isSelect) => setState(() => _options[option] = isSelect ?? false),
                      title: Text(option.toString()),
                    )
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _selectedOptions),
              child: const Text("Save")
            )
          ],
        ),
      )
    );
  }
}