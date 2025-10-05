import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({required this.onSwitchMode, super.key});
  final void Function(bool) onSwitchMode;

  @override
  State<SwitchButton> createState() {
    return _SwitchButton();
  }
}

class _SwitchButton extends State<SwitchButton> {
  bool mode = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: mode,
      onChanged: (value) {
        setState(() {
          mode = value;
          widget.onSwitchMode(mode);
        });
      },
    );
  }
}
