import 'package:flutter/material.dart';

import '../arithmetic/addition_subtraction.dart';
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
