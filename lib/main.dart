import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kaushal/values/colors.dart';
import 'package:provider/provider.dart';
import 'utils/shared_pref_util.dart';
import 'utils/theme_util.dart';
import 'values/strings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
  List _results = ["0", "0", "0", "0"];
  double _progress = 100.0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _currentTimer = 10;
  num _firstNum = 0;
  num _secondNum = 0;
  String _currentResult = "";
  String _currentTimerToDisplay = "10s";
  String _operation = "";
  String _result = "";
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
      body: _operation != ""
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (_currentTimer > 0)
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
                if (_currentTimer > 0)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _getButton(0),
                            _getButton(1),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _getButton(2),
                            _getButton(3),
                          ],
                        ),
                      ),
                    ],
                  ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          _currentTimer > 0
                              ? _currentResult
                              : "Correct Answers: $_correctAnswers\n\nWrong Answers: $_wrongAnswers",
                          textScaleFactor: 1,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        if (_currentTimer == 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => setOperation("+"),
                                  child: const Text("+", textScaleFactor: 2),
                                ),
                                ElevatedButton(
                                  onPressed: () => setOperation("-"),
                                  child: const Text("-", textScaleFactor: 2),
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
                                child: const Text("x", textScaleFactor: 2),
                              ),
                              ElevatedButton(
                                onPressed: () => setOperation("/"),
                                child: const Text("/", textScaleFactor: 2),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => setOperation("+"),
                          child: const Text("+", textScaleFactor: 2),
                        ),
                        ElevatedButton(
                          onPressed: () => setOperation("-"),
                          child: const Text("-", textScaleFactor: 2),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => setOperation("*"),
                          child: const Text("x", textScaleFactor: 2),
                        ),
                        ElevatedButton(
                          onPressed: () => setOperation("/"),
                          child: const Text("/", textScaleFactor: 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void setOperation(String operation) {
    _currentResult = "";
    _currentTimerToDisplay = "10s";
    _operation = "";
    _result = "";
    _progress = 100;
    _currentTimer = 10;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _operation = operation;
    _generateQuestion();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (_currentTimer == 0) {
        t.cancel();
      }
      if (_currentTimer > 0) {
        _currentTimer = _currentTimer - 1;
      }
      _progress = (_currentTimer / 10).toDouble();
      _currentTimerToDisplay = (_currentTimer < 10 ? "0" : "").toString() +
          _currentTimer.toString() +
          "s";
      setState(() {});
    });
  }

  ElevatedButton _getButton(int index) => ElevatedButton(
      onPressed: () => _submitAnswer(_results[index].toString()),
      child: Text(_results[index].toString(), textScaleFactor: 2));
  void _generateQuestion() {
    Random random = Random();
    _results = [];
    switch (_operation) {
      case '+':
        _firstNum = Random().nextInt(100) + 1;
        _secondNum = Random().nextInt(100) + 1;
        num total = _firstNum + _secondNum;
        _result = total.toString();
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = random.nextInt(3) + 1;
          num newNum = 0;
          if (randomNum.isEven) {
            newNum = total + (randomNum * 10) as int;
          } else {
            newNum = total - (randomNum * 10) as int;
          }
          if (!_results.contains(newNum.toString()) &&
              newNum
                  .toString()
                  .endsWith(total.toString()[total.toString().length - 1])) {
            _results.add(newNum.toString());
          }
        }
        break;
      case '-':
        _firstNum = Random().nextInt(100) + 1;
        _secondNum = Random().nextInt(100) + 1;
        num total = _firstNum - _secondNum;
        _result = total.toString();
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = random.nextInt(50) + 1;
          num newNum = 0;
          if (randomNum.isEven) {
            newNum = total - randomNum as int;
          } else {
            newNum = total + randomNum as int;
          }
          if (!_results.contains(newNum.toString())) {
            _results.add(newNum.toString());
          }
        }
        break;
      case '*':
        _firstNum = Random().nextInt(100) + 1;
        _secondNum = Random().nextInt(25) + 1;
        num total = _firstNum * _secondNum;
        _result = total.toString();
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = random.nextInt(11);
          num newNum = 0;
          if (randomNum.isEven) {
            newNum = total + randomNum + 1 as int;
          } else {
            newNum = total - randomNum + 1 as int;
          }
          if (!_results.contains(newNum.toString())) {
            _results.add(newNum.toString());
          }
        }
        break;
      case '/':
        _firstNum = Random().nextInt(100) + 1;
        _secondNum = Random().nextInt(100) + 1;
        num total = _firstNum / _secondNum;
        _result = total.toStringAsFixed(1);
        _results.add(_result);
        while (_results.length < 4) {
          var randomNum = random.nextInt(11);
          num x = 0;
          if (randomNum.isEven) {
            x = total + randomNum + 1;
          } else {
            x = total - randomNum + 1;
          }
          if (!_results.contains(x.toStringAsFixed(1))) {
            _results.add(x.toStringAsFixed(1));
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
