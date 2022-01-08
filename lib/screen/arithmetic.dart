import 'dart:math';

import 'package:flutter/material.dart';

import '../../widgets/anime.dart';
import '../../widgets/keypad.dart';

class Arithmetic extends StatefulWidget {
  final bool isAddition;
  const Arithmetic({Key? key, required this.isAddition}) : super(key: key);

  @override
  _AdditionSubtractionState createState() => _AdditionSubtractionState();
}

class _AdditionSubtractionState extends State<Arithmetic> {
  String _currentNum = "";
  String _currentAnswer = "";
  String _currentQuestion = "";
  bool _gameStart = false;

  void generateQuestion() {
    if (widget.isAddition) {
      int num1 = Random().nextInt(10);
      int num2 = Random().nextInt(10);
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
    } else {
      int num1 = Random().nextInt(10);
      int num2 = Random().nextInt(10);
      final operator = Random().nextInt(2);

      if (operator == 0) {
        while (num2 == 0 || num1 == 0) {
          num2 = Random().nextInt(10);
          num1 = Random().nextInt(10);
        }
        _currentQuestion = "$num1 x $num2";
        _currentAnswer = (num1 * num2).toString();
      } else {
        while (num1 < num2 || num2 == 0) {
          num1 = Random().nextInt(10);
          num2 = Random().nextInt(10);
        }
        _currentQuestion = "${num1 * num2} ÷ $num1";
        _currentAnswer = (num2).toString();
      }
      setState(() {
        _currentNum = "";
      });
    }
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

  _startGame() {
    setState(() {
      _gameStart = true;
    });
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
        title: Text(widget.isAddition
            ? 'Addition & Subtraction'
            : 'Multiplication & Division'),
      ),
      body: _gameStart
          ? Column(
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
                      color: _isCorrect
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.error),
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
            )
          : Anime(startShow: _startGame),
    );
  }
}
