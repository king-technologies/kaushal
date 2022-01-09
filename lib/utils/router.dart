import 'package:flutter/material.dart';

import '../screen/arithmetic.dart';
import '../screen/one_focus.dart';
import '../screen/settings.dart';
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
        return MaterialPageRoute(
            builder: (_) => const Arithmetic(isAddition: true));
      case mulDiv:
        return MaterialPageRoute(
            builder: (_) => const Arithmetic(isAddition: false));
      case oneFocus:
        return MaterialPageRoute(builder: (_) => const OneFocus());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const Settings());
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
