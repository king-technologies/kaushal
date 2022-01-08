import 'dart:async';

import 'package:flutter/material.dart';

class Anime extends StatefulWidget {
  final Function startShow;
  const Anime({Key? key, required this.startShow}) : super(key: key);

  @override
  _AnimeState createState() => _AnimeState();
}

class _AnimeState extends State<Anime> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  late AnimationController animationController;
  int x = 3;
  String y = "3";
  late Timer timer;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    timer = Timer.periodic(const Duration(seconds: 1), (V) {
      if (x == 0) {
        V.cancel();
        timer.cancel();
        widget.startShow();
      } else {
        x--;
        y = x == 0 ? "Go!" : x.toString();
        if (mounted) {
          setState(() {});
        }
      }
    });
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedLogo(y, animation: animation),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final String x;
  AnimatedLogo(this.x, {Key? key, Animation? animation})
      : super(key: key, listenable: animation!);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Transform.scale(
        scale: animation.value + 3,
        child: Text(
          x,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
