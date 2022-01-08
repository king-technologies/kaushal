import 'package:flutter/material.dart';

import '../screen/one_focus.dart';
import '../screen/arithmetic.dart';
import '../values/strings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args;
    if (settings.arguments != null) {
      args = settings.arguments;
    }
    switch (settings.name) {
      case addSub:
        return MaterialPageRoute(
            builder: (_) => const Arithmetic(isAddition: true));
      case mulDiv:
        return MaterialPageRoute(
            builder: (_) => const Arithmetic(isAddition: false));
      case oneFocus:
        return MaterialPageRoute(builder: (_) => const OneFocus());
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
