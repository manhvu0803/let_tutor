import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      padding: 0,
      child: Stack(
        children: [
          Container(decoration: const BoxDecoration(color: Colors.black)),
          Positioned(
            top: 100,
            left: 50,
            child: ExpandableNotifier(
              child: ScrollOnExpand(
                child: Expandable(
                  collapsed: _ExpandButton(),
                  expanded: Column(
                    children: [
                      _ExpandButton(),
                      const _MeetingButton(icon: Icons.mic, optionalReversedIcon: Icons.mic_off, onPressed: null),
                      const _MeetingButton(icon: Icons.video_call),
                      const _MeetingButton(icon: Icons.chat_bubble),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}

class _ExpandButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableButton(
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.grey)
        ),
        child: const Icon(Icons.expand_more, color: Colors.white, size: 30),
      ),
    );
  }
}

class _MeetingButton extends StatefulWidget {
  final IconData icon;

  final IconData? reversedIcon;

  final Function()? onPressed;

  const _MeetingButton({required this.icon, optionalReversedIcon, this.onPressed})
    : reversedIcon = optionalReversedIcon ?? icon;

  @override
  State<StatefulWidget> createState() => _MeetingButtonState();
}

class _MeetingButtonState extends State<_MeetingButton> {
  bool _isEnable = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: SizedBox(
        width: 75,
        height: 75,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black12,
            side: const BorderSide(width: 1, color: Colors.grey)
          ),
          onPressed: _switchState,
          child: Icon(_isEnable? widget.icon : widget.reversedIcon, color: Colors.white, size: 30)
        ),
      ),
    );
  }

  void _switchState() {
    setState(() => _isEnable = !_isEnable);
    widget.onPressed?.call();
  }
}