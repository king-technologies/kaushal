import 'package:flutter/material.dart';

import '../arithmetic/addition_subtraction.dart';
import '../arithmetic/multiplication_division.dart';
import '../values/strings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args;
    if (settings.arguments != null) {
      args = settings.arguments;
    }
    debugPrint(args);
    switch (settings.name) {
      case addSub:
        return MaterialPageRoute(builder: (_) => const AdditionSubtraction());
      case mulDiv:
        return MaterialPageRoute(
            builder: (_) => const MultiplicationDivision());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
