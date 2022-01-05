import 'package:flutter/material.dart';

class Keypad extends StatelessWidget {
  const Keypad({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
    required this.isDot,
  }) : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final bool isDot;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          ".",
          "0",
          "Clear"
        ].map((e) {
          if (!isDot && e == ".") {
            return const ElevatedButton(
              onPressed: null,
              child: null,
            );
          } else if (e != "Clear") {
            return ElevatedButton(
                onPressed: () => onTextInput(e), child: Text(e));
          } else {
            return ElevatedButton(
              onPressed: onBackspace,
              child: const Icon(
                Icons.keyboard_backspace_rounded,
                color: Colors.black,
                size: 15,
              ),
            );
          }
        }).toList(),
        crossAxisCount: 3,
        childAspectRatio: 1.6,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
    );
  }
}
