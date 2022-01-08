import "package:flutter/material.dart";
import "package:kaushal/utils/router.dart";
import "package:provider/provider.dart";

import 'utils/shared_pref_util.dart';
import "utils/theme_util.dart";
import "values/strings.dart";

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeUtils(),
        builder: (context, _) {
          final themeUtils = Provider.of<ThemeUtils>(context);
          SharedPref.getTheme().then((value) =>
              Provider.of<ThemeUtils>(context, listen: false)
                  .toggleTheme(value == 1));
          return MaterialApp(
            title: appName,
            themeMode: themeUtils.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const MyHome(),
          );
        },
      ),
    );

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    SharedPref.getTheme().then((value) =>
        Provider.of<ThemeUtils>(context, listen: false)
            .toggleTheme(value == 1));
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("One Focus [  +  -  x  ÷  ]"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, oneFocus);
              },
            ),
            ListTile(
              title: const Text("Addition & Subtraction"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, addSub);
              },
            ),
            ListTile(
              title: const Text("Multiplication & Division"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, mulDiv);
              },
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, settings);
              },
            ),
            ListTile(
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, about);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          "Welcome to Kaushal",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
