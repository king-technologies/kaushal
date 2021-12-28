import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kaushal/values/colors.dart';
import 'package:provider/provider.dart';

import 'utils/shared_pref_util.dart';
import 'utils/theme_util.dart';
import 'values/strings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeUtils(),
      builder: (context, _) {
        final themeUtils = Provider.of<ThemeUtils>(context);
        return MaterialApp(
          title: appName,
          themeMode: themeUtils.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _operations = ['+', '-', '*', '/'];
  List _results = ["0", "0", "0", "0"];
  String _currentResult = "";
  String _currentTimerToDisplay = "";
  String _operation = '';
  String _result = "";
  bool _isTimerRunning = true;
  double _progress = 0.0;
  int _currentTimer = 10;
  num _firstNum = 0;
  num _secondNum = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  bool _isGo = false;
  bool _doRestart = true;

  @override
  void initState() {
    super.initState();
    SharedPref.getTheme().then((value) =>
        Provider.of<ThemeUtils>(context, listen: false)
            .toggleTheme(value == 1));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final themeUtils = Provider.of<ThemeUtils>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: () {
              themeUtils.themeMode == ThemeMode.dark
                  ? themeUtils.toggleTheme(false)
                  : themeUtils.toggleTheme(true);
            },
            icon: Icon(themeUtils.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: _isGo
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (_doRestart)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: mq.size.width * 0.15,
                            minWidth: mq.size.width * 0.15,
                            minHeight: mq.size.width * 0.15,
                            maxHeight: mq.size.width * 0.15,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(),
                              if (_isTimerRunning)
                                Text(
                                  _currentTimerToDisplay,
                                  textScaleFactor: 1,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              if (_isTimerRunning)
                                Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(3.14),
                                  child: CircularProgressIndicator(
                                    value: _progress,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        themeUtils.themeMode == ThemeMode.dark
                                            ? Colors.white
                                            : kPrimaryColor),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          color: themeUtils.themeMode != ThemeMode.dark
                              ? kPrimaryColor
                              : Colors.white,
                          child: Text(
                            '$_firstNum $_operation $_secondNum',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(
                          width: mq.size.width * 0.15,
                          height: mq.size.width * 0.15,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    if (_doRestart)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _getButton(0),
                          _getButton(1),
                        ],
                      ),
                    if (_doRestart) const SizedBox(height: 10),
                    if (_doRestart)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _getButton(2),
                          _getButton(3),
                        ],
                      ),
                    if (_doRestart) const SizedBox(height: 10),
                    const SizedBox(height: 30),
                    Text(
                      _isTimerRunning
                          ? _currentResult
                          : "Correct Answers: $_correctAnswers\n\nWrong Answers: $_wrongAnswers",
                      textScaleFactor: 1,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    if (!_doRestart) const SizedBox(height: 10),
                    if (!_doRestart)
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _doRestart = true;
                              _results = ["0", "0", "0", "0"];
                              _currentResult = "";
                              _currentTimerToDisplay = "";
                              _operation = '';
                              _result = "";
                              _isTimerRunning = true;
                              _progress = 0.0;
                              _currentTimer = 10;
                              _firstNum = 0;
                              _secondNum = 0;
                              _correctAnswers = 0;
                              _wrongAnswers = 0;
                              _isGo = true;
                              _doRestart = true;
                            });
                            _generateQuestion();
                            _correctAnswers = 0;
                            _wrongAnswers = 0;
                            Timer.periodic(
                              const Duration(seconds: 1),
                              (Timer t) {
                                if (mounted) {
                                  _currentTimerToDisplay =
                                      (_currentTimer < 10 ? "0" : "").toString() +
                                          _currentTimer.toString() +
                                          "s";
                                  if (_currentTimer > 0) {
                                    _currentTimer = _currentTimer - 1;
                                    _progress = (_currentTimer / 10).toDouble();
                                  } else if (_currentTimer == 0) {
                                    _isTimerRunning = false;
                                    _doRestart = false;
                                    t.cancel();
                                  }
                                  setState(() {});
                                }
                              },
                            );
                            _generateQuestion();
                          },
                          child: const Text("Go"),
                        ),
                      ),
                  ],
                ),
              ],
            )
          : Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isGo = true;
                      _isTimerRunning = true;
                    });
                    _generateQuestion();
                    Timer.periodic(
                      const Duration(seconds: 1),
                      (Timer t) {
                        if (mounted) {
                          _currentTimerToDisplay =
                              (_currentTimer < 10 ? "0" : "").toString() +
                                  _currentTimer.toString() +
                                  "s";
                          if (_currentTimer > 0) {
                            _currentTimer = _currentTimer - 1;
                            _progress = (_currentTimer / 10).toDouble();
                          } else if (_currentTimer == 0) {
                            _isTimerRunning = false;
                            _doRestart = false;
                            t.cancel();
                          }
                          setState(() {});
                        }
                      },
                    );
                    _generateQuestion();
                  },
                  child: const Text("Go")),
            ),
    );
  }

  ElevatedButton _getButton(int index) => ElevatedButton(
        onPressed: () => _submitAnswer(_results[index].toString()),
        child: Text(_results[index].toString()),
      );

  String _getRandomOperation() =>
      _operations[Random().nextInt(_operations.length)];

  List _calculateResults(_firstNum, _secondNum, _operation) {
    List temp = [];
    switch (_operation) {
      case '+':
        temp.add(_firstNum + _secondNum);
        temp.add(_firstNum + _secondNum + 1);
        temp.add(_firstNum + _secondNum + 2);
        temp.add(_firstNum + _secondNum - 1);
        return temp;
      case '-':
        temp.add(_firstNum - _secondNum);
        temp.add(_firstNum - _secondNum + 1);
        temp.add(_firstNum - _secondNum + 2);
        temp.add(_firstNum - _secondNum - 1);
        return temp;
      case '*':
        temp.add(_firstNum * _secondNum);
        temp.add(_firstNum * _secondNum + 1);
        temp.add(_firstNum * _secondNum + 2);
        temp.add(_firstNum * _secondNum - 1);
        return temp;
      case '/':
        temp.add((_firstNum / (_secondNum + 1)).toStringAsPrecision(3));
        temp.add((_firstNum / (_secondNum + 2)).toStringAsPrecision(3));
        temp.add((_firstNum / (_secondNum - 1)).toStringAsPrecision(3));
        temp.add((_firstNum / _secondNum).toStringAsPrecision(3));
        return temp;
      default:
        return temp;
    }
  }

  String _calculateResult(_firstNum, _secondNum, _operation) {
    switch (_operation) {
      case '+':
        return (_firstNum + _secondNum).toString();
      case '-':
        return (_firstNum - _secondNum).toString();
      case '*':
        return (_firstNum * _secondNum).toString();
      case '/':
        num x = _firstNum / _secondNum;
        return x.toStringAsPrecision(3);
      default:
        return "0";
    }
  }

  void _generateQuestion() {
    _operation = _getRandomOperation();
    if (_operation == '/' || _operation == '*') {
      _firstNum = Random().nextInt(100) + 1;
      _secondNum = Random().nextInt(25) + 1;
      while (_secondNum > _firstNum) {
        _firstNum = Random().nextInt(100) + 1;
        _secondNum = Random().nextInt(25) + 1;
      }
    } else {
      _firstNum = Random().nextInt(100) + 1;
      _secondNum = Random().nextInt(100) + 1;
    }
    _result = _calculateResult(_firstNum, _secondNum, _operation);
    _results = _calculateResults(_firstNum, _secondNum, _operation);
    _results.shuffle();
    setState(() {});
  }

  void _submitAnswer(String option) {
    if (!_isGo) return;
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
