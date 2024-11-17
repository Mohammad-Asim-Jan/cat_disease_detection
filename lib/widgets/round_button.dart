import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RoundButton extends StatefulWidget {
  const RoundButton({
    super.key,
    required this.title,
    required this.onPress,
    this.unFill = false,
    this.loading = false,
  });

  final bool loading;
  final bool unFill;
  final String title;
  final VoidCallback onPress;

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return widget.loading
        ? Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.unFill ? Colors.transparent : Constants.mainColor,
                borderRadius: BorderRadius.circular(8)),
            child: const CircularProgressIndicator(
              color: Colors.red,
            ),
          )
        : InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color:
                      widget.unFill ? Colors.transparent : Constants.mainColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          );
  }
}
