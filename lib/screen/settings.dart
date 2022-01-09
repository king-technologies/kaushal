import "package:flutter/material.dart";
import 'package:kaushal/values/strings.dart';
import 'package:provider/provider.dart';

import '../utils/theme_util.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeUtils = Provider.of<ThemeUtils>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10),
                    child: Text("Account",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.person_rounded, color: Colors.green),
                    title: const Text("Personal Details"),
                    onTap: () => Navigator.pushNamed(context, "/profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  const Divider(height: 2, thickness: 0.1),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.green),
                    title: const Text("Preferences"),
                    onTap: () => Navigator.pushNamed(context, "/profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10),
                    child: Text("App Setting",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  ListTile(
                    iconColor: Colors.blue,
                    leading: Icon(themeUtils.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode),
                    title: const Text("Dark Mode"),
                    onTap: () => Navigator.pushNamed(context, "/profile"),
                    trailing: Switch(
                      value: themeUtils.themeMode == ThemeMode.dark,
                      onChanged: (value) => themeUtils.toggleTheme(value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10),
                    child: Text("Help",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.error_rounded, color: Colors.blue),
                    title: const Text("Support"),
                    onTap: () => Navigator.pushNamed(context, "/profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  const Divider(height: 2, thickness: 0.1),
                  ListTile(
                    leading: const Icon(Icons.question_mark_rounded,
                        color: Color.fromARGB(255, 219, 164, 73)),
                    title: const Text("FAQs"),
                    onTap: () => Navigator.pushNamed(context, "/profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.logout_rounded, color: Colors.blue),
                    title: const Text("Logout"),
                    onTap: () => Navigator.pushNamed(context, "/profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  const Divider(height: 2, thickness: 0.1),
                  ListTile(
                    leading: const Icon(Icons.delete_forever_rounded,
                        color: Colors.red),
                    title: const Text("Delete Account"),
                    onTap: () => Navigator.pushNamed(context, "/profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(appName + " by King Tech, v1.0.0")),
            const Text("Made with ❣️ in India"),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
