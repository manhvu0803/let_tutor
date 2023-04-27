import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/data_model/user.dart';
import 'package:let_tutor/data_model/user_model.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/multiselect_dialog.dart';
import 'package:let_tutor/widgets/try_async_button.dart';
import 'package:provider/provider.dart';

const _inputDecoration = InputDecoration(
  border: OutlineInputBorder()
);

const _disableDecoration = InputDecoration(
  border: OutlineInputBorder(),
  fillColor: Colors.grey
);

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  DateTime _birthday = DateTime(2000);
  String _level = User.levelStrings.first.replaceAll("-", "_").toUpperCase();
  Set<String> _interests = {};
  String _name = "";
  String _country = "VN";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var user = context.read<UserModel>().user;
      setState(() {
        _birthday = user.birthday;

        if (user.level.isNotEmpty) {
          _level = user.level.replaceAll("-", "_").toUpperCase();
        }

        _name = user.name;
        if (User.countries.containsKey(user.country)) {
          _country = user.country;
        }
        else {
          _country = User.countries.keys.first;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 20
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
            Consumer<UserModel>(
              builder: (context, model, child) => ListView(
                children: [
                  // Name
                  const _LabelText("Name"),
                  _InputField(
                    initialData: model.user.name,
                    onChange: (value) => _name = value,
                  ),
                  // Country
                  const _LabelText("Country"),
                  DropdownButtonFormField(
                    decoration: _inputDecoration,
                    value: _country,
                    items: User.countries.keys.toNewList((key) {
                      return DropdownMenuItem(
                        value: key,
                        child: Text(User.countries[key]!)
                      );
                    }),
                    onChanged: (value) => setState(() => _country = value ?? _country)
                  ),
                  // Phone
                  const _LabelText("Phone number"),
                  _InputField(initialData: model.user.phone, enabled: false),
                  // Birthday
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: _LabelText("Birthday"),
                        ),
                        SizedBox(
                          width: 150,
                          child: OutlinedButton(
                            onPressed: () => _pickBirthday(context),
                            child: Text(_birthday.isoDateString, style: const TextStyle(fontSize: 20))
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Level
                  const _LabelText("Level"),
                  DropdownButtonFormField(
                    decoration: _inputDecoration,
                    value: _level,
                    onChanged: (value) => setState(() => _level = value ?? _level),
                    items: User.levelStrings.toNewList((level) {
                      return DropdownMenuItem(
                      value: level.replaceAll("-", "_").toUpperCase(),
                      child: Text(level)
                    );}),
                  ),
                  // Interest
                  const _LabelText("Want to learn"),
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _showInterestDialog(context),
                      child: Text(_interestsToString())
                    ),
                  ),
                  // Schedule
                  const _LabelText("Study schedule"),
                  const TextField(
                    decoration: _inputDecoration,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8
                  ),
                  // Submit
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                    child: SizedBox(
                      height: 70,
                      child: TryAsyncButton(
                        doublePop: false,
                        showServerMessage: false,
                        postData: () => updateUserInfo(
                          name: _name,
                          country: _country,
                          birthday: _birthday,
                          level: _level,
                          phone: model.user.phone
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
    );
  }

  void _showInterestDialog(BuildContext context) async {
    var interests = await showDialog<Set<String>>(
      context: context,
      builder: (context) => const MultiselectDialog(options: {"IELTS": false, "FLYERS": false, "MOVERS": true})
    );

    if (interests != null) {
      setState(() => _interests = interests);
    }
  }

  String _interestsToString() {
    var buffer = StringBuffer();
    int count = 0;

    for (final interest in _interests) {
      if (count > 0) {
        buffer.write(", ");
      }

      buffer.write(interest);
      count++;
    }

    return buffer.toString();
  }

  void _pickBirthday(BuildContext context) async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
    );

    if (chosenDate != null) {
      setState(() => _birthday = chosenDate);
    }
  }
}

class _InputField extends StatefulWidget {
  final bool enabled;
  final String? initialData;
  final Function(String)? onChange;

  const _InputField({this.enabled = true, this.initialData, this.onChange});

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _controller.text = widget.initialData!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChange,
      controller: _controller,
      decoration: widget.enabled ? _inputDecoration : _disableDecoration,
      enabled: widget.enabled
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _LabelText extends StatelessWidget {
  final String text;

  const _LabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(text),
    );
  }
}