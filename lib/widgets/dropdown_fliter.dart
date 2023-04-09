import 'package:flutter/material.dart';
import 'package:let_tutor/utils/utils.dart';

class DropdownFilter<T> extends StatelessWidget {
  final T? value;
  final void Function(T?)? onChanged;
  final Map<T, String> options;
  final String name;
  final bool allowNullOption;

  const DropdownFilter({
    super.key,
    this.value,
    this.onChanged,
    required this.options,
    required this.name,
    this.allowNullOption = true
  });

  DropdownFilter.iterable({
    super.key,
    this.value,
    this.onChanged,
    required Iterable<T> options,
    required this.name, this.allowNullOption = true
  }) :
    options = options.toValueMap((item) => item.toString());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(name, style: const TextStyle(fontSize: 18)),
          ),
          DropdownButton<T>(
            value: value,
            onChanged: onChanged,
            items: [
              if (allowNullOption) const DropdownMenuItem(
                value: null,
                child: Text("Any")
              ),
              ...buildList(options.keys, (option) => DropdownMenuItem(
                value: option,
                child: Text(options[option]!),
              ))
            ]
          ),
        ],
      ),
    );
  }
}