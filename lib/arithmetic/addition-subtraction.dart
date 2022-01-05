import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/keypad.dart';

class AdditionSubtraction extends StatefulWidget {
  const AdditionSubtraction({Key? key}) : super(key: key);

  @override
  _AdditionSubtractionState createState() => _AdditionSubtractionState();
}

class _AdditionSubtractionState extends State<AdditionSubtraction> {
  String _currentNum = "";
  String _currentAnswer = "";
  String _currentQuestion = "";

  void generateQuestion() {
    int num1 = Random().nextInt(20);
    int num2 = Random().nextInt(20);
    final operator = Random().nextInt(2);
    if (operator != 0) {
      while (num2 > num1) {
        num2 = Random().nextInt(10);
        num1 = Random().nextInt(10);
      }
    }
    setState(() {
      _currentNum = "";
      _currentAnswer = (operator == 0 ? num1 + num2 : num1 - num2).toString();
      _currentQuestion =
          num1.toString() + (operator == 0 ? " + " : " - ") + num2.toString();
    });
  }

  bool get _isCorrect {
    if (_currentNum == _currentAnswer ||
        _currentNum.isNotEmpty &&
            _currentAnswer.length == 2 &&
            _currentNum == _currentAnswer.substring(0, 1)) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addition and Subtraction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(),
            Text(
              _currentQuestion,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              _currentNum,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: _isCorrect ? Colors.black : Colors.redAccent),
            ),
            Keypad(
              onBackspace: () {
                if (_currentNum.isEmpty) {
                  return;
                }
                if (_currentNum.isNotEmpty) {
                  _currentNum =
                      _currentNum.substring(0, _currentNum.length - 1);
                }
                if (_currentAnswer == _currentNum) {
                  generateQuestion();
                } else {
                  setState(() {});
                }
              },
              onTextInput: (String value) {
                if ((_currentNum + value).length > 2) {
                  return;
                }
                _currentNum += value;
                if (_currentAnswer == _currentNum) {
                  generateQuestion();
                } else {
                  setState(() {});
                }
              },
              isDot: false,
            )
          ],
        ),
      ),
    );
  }
}
