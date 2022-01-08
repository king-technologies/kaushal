import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/theme_util.dart';

class OneFocus extends StatefulWidget {
  const OneFocus({Key? key}) : super(key: key);
  @override
  State<OneFocus> createState() => _OneFocusState();
}

class _OneFocusState extends State<OneFocus> {
  List _results = ["0", "0", "0", "0"];
  double _progress = 100;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _currentTimer = 30;
  num _firstNum = 0;
  num _secondNum = 0;
  String _currentResult = "";
  String _currentTimerToDisplay = "30s";
  String _operation = "";
  String _result = "";
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final themeUtils = Provider.of<ThemeUtils>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('One Focus'),
      ),
      body: _operation != ""
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentTimer > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: mq.size.width * 0.15,
                            minWidth: mq.size.width * 0.15,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                _currentTimerToDisplay,
                                textScaleFactor: 1,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(3.14),
                                child: CircularProgressIndicator(
                                  value: _progress,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      themeUtils.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          color: themeUtils.themeMode != ThemeMode.dark
                              ? Colors.black
                              : Colors.white,
                          child: Text(
                            "$_firstNum $_operation $_secondNum",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(
                          width: mq.size.width * 0.15,
                        ),
                      ],
                    ),
                  ),
                if (_currentTimer > 0)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _getButton(0, mq),
                            _getButton(1, mq),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _getButton(2, mq),
                            _getButton(3, mq),
                          ],
                        ),
                      ),
                    ],
                  ),
                Column(
                  children: [
                    Padding(
                      padding: _currentTimer > 0
                          ? const EdgeInsets.only(top: 20)
                          : const EdgeInsets.all(0),
                      child: Text(
                        _currentTimer > 0
                            ? _currentResult
                            : "Correct: $_correctAnswers\n\nWrong: $_wrongAnswers",
                        textScaleFactor: 1,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    if (_currentTimer == 0) const SizedBox(height: 20),
                    if (_currentTimer == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => setOperation("+"),
                              child: Text(
                                "+",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => setOperation("-"),
                              child: Text(
                                "-",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_currentTimer == 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => setOperation("*"),
                            child: Text(
                              "x",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => setOperation("÷"),
                            child: Text(
                              "÷",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: mq.size.width * 0.15,
                        child: ElevatedButton(
                          onPressed: () => setOperation("+"),
                          child: Text(
                            "+",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mq.size.width * 0.15,
                        child: ElevatedButton(
                          onPressed: () => setOperation("-"),
                          child: Text(
                            "-",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: mq.size.width * 0.15,
                        child: ElevatedButton(
                          onPressed: () => setOperation("*"),
                          child: Text(
                            "x",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mq.size.width * 0.15,
                        child: ElevatedButton(
                          onPressed: () => setOperation("÷"),
                          child: Text(
                            "÷",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void setOperation(String operation) {
    _currentResult = "";
    _currentTimerToDisplay = "30s";
    _operation = "";
    _result = "";
    _progress = 100;
    _currentTimer = 30;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _operation = operation;
    _generateQuestion();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (_currentTimer > 0) {
        _currentTimer = _currentTimer - 1;
      }
      if (_currentTimer <= 0) {
        t.cancel();
        _timer.cancel();
      }
      _progress = (_currentTimer / 30).toDouble();
      _currentTimerToDisplay = (_currentTimer < 10 ? "0" : "").toString() +
          _currentTimer.toString() +
          "s";
      setState(() {});
    });
  }

  SizedBox _getButton(int index, MediaQueryData mq) => SizedBox(
        width: mq.size.width * 0.26,
        child: ElevatedButton(
            onPressed: () => _submitAnswer(_results[index].toString()),
            child: Text(
              _results[index].toString(),
              style: Theme.of(context).textTheme.headline6,
            )),
      );

  void _generateQuestion() {
    Random random = Random();
    _results = [];
    switch (_operation) {
      case "+":
        _firstNum = Random().nextInt(100) + 10;
        _secondNum = Random().nextInt(100) + 1;
        num total = _firstNum + _secondNum;
        _result = total.toString();
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = (random.nextInt(4) + 1) * 10;
          num newNum = 0;
          newNum = randomNum.isEven ? total + randomNum : total - randomNum;
          if (!_results.contains(newNum.toString()) &&
              newNum.toString().endsWith(_result[_result.length - 1])) {
            _results.add(newNum.toString());
          }
        }
        break;
      case "-":
        _firstNum = Random().nextInt(100) + 1;
        _secondNum = Random().nextInt(100) + 1;
        num total = _firstNum - _secondNum;
        _result = total.toString();
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = random.nextInt(50) + 1;
          num newNum = 0;
          newNum = randomNum.isEven ? total - randomNum : total + randomNum;
          if (!_results.contains(newNum.toString())) {
            _results.add(newNum.toString());
          }
        }
        break;
      case "*":
        _firstNum = Random().nextInt(25) + 1;
        _secondNum = Random().nextInt(25) + 1;
        num total = _firstNum * _secondNum;
        _result = total.toString();
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = random.nextInt(25) + 1;
          num newNum = 0;
          newNum = randomNum.isEven ? total + randomNum : total - randomNum;
          if (!_results.contains(newNum.toString())) {
            _results.add(newNum.toString());
          }
        }
        break;
      case "÷":
        _firstNum = Random().nextInt(25) + 1;
        _secondNum = Random().nextInt(25) + 1;
        while (_firstNum < _secondNum) {
          _firstNum = Random().nextInt(25) + 1;
          _secondNum = Random().nextInt(25) + 1;
        }
        var _secondTemp = _secondNum;
        var temp = _firstNum * _secondNum;
        _secondNum = _firstNum;
        _firstNum = temp;
        _result = _secondTemp.toString();
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = random.nextInt(25) + 1;
          num newNum = 0;
          newNum = randomNum.isEven
              ? _secondTemp + randomNum
              : _secondTemp - randomNum;
          if (!_results.contains(newNum.toString()) && newNum > 0) {
            _results.add(newNum.toString());
          }
        }
        break;
      default:
        _result = "0";
        _results = ["0", "0", "0", "0"];
    }
    _results.shuffle();
    setState(() {});
  }

  void _submitAnswer(String option) {
    if (option == _result) {
      _currentResult = "Correct!";
      _correctAnswers++;
    } else {
      _currentResult = "Wrong!";
      _wrongAnswers++;
    }
    _generateQuestion();
  }
}
