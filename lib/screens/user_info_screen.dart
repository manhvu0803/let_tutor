import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/course.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/date_time_extension.dart';
import 'package:let_tutor/utils/utils.dart';

const _inputDecoration = InputDecoration(
  border: OutlineInputBorder()
);

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  DateTime _birthday = DateTime(2000);

  @override
  Widget build(BuildContext context) {

    return Screen(
      child: Column(
        children: [
          const Text("Name"),
          const _InputField(),
          const Text("Country"),
          DropdownButtonFormField(
            decoration: _inputDecoration,
            items: const [
              DropdownMenuItem(
                value: "VN",
                child: Text("Viet Nam")
              ),
              DropdownMenuItem(
                value: "US",
                child: Text("USA")
              )
            ],
            onChanged: (value) {}
          ),
          const Text("Phone number"),
          const _InputField(enabled: false),
          const Text("Birthday"),
          OutlinedButton(
            onPressed: () => _pickBirthday(context),
            child: Text(_birthday.isoDateString)
          ),
          const Text("Level"),
          DropdownButtonFormField(
            decoration: _inputDecoration,
            onChanged: (value) {},
            items: Course.levelStrings.toNewList((level) => DropdownMenuItem(
              value: level.replaceAll("-", "_").toUpperCase(),
              child: Text(level)
            )),
          )
        ],
      ),
    );
  }

  void _pickBirthday(BuildContext context) async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(2000),
      lastDate: DateTime.now()
    );

    if (chosenDate != null) {
      setState(() => _birthday = chosenDate);
    }
  }
}

class _InputField extends StatelessWidget {
  final bool enabled;

  const _InputField({super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: _inputDecoration,
      enabled: enabled
    );
  }
}