import 'package:entrega/variables/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:entrega/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:entrega/pages/helpsupport_view.dart';
import 'package:entrega/main.dart';

// ignore: must_be_immutable
class SettingPage extends StatefulWidget {
  HomePageState homePageState;
  bool dobleClosed;

  SettingPage({Key? key, required this.homePageState, required this.dobleClosed})
      : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _darkMode = false;
  bool _onNotification = false;

  ThemeData get _currentTheme => _darkMode ? ThemeData.dark() : ThemeData.light();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _userLogout(
      BuildContext context, HomePageState homePageState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(preferenceIsLogin, false);
    prefs.setString(preferenceLoginUsername, "");

    homePageState.setIsLogin(false);
    homePageState.setLoginUsername("");
    homePageState.setLoginCanListUsers(false);
    homePageState.setLoginIsAdministrator(false);
    homePageState.setLoginIsCustomer(false);

  //  homePageState.isNewImage1 = false;
  //  homePageState.isNewImage2 = false;

    Navigator.pop(context);

    homePageState.refresh();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void _toggleDarkMode(bool val) async {
    isBlack = val;
    final prefs = await SharedPreferences.getInstance();
    setState(() => _darkMode = val);
    prefs.setBool('darkMode', val);
    themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _currentTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(menuSettingsTitle),
          backgroundColor: _darkMode ? Colors.grey[900] : Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // User Profile Card
           widget.homePageState.isLogin?Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(widget.homePageState.loginUsername),
                subtitle: Text(loggedInUser),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Edit profile logic
                  },
                ),
              ),
            ):Container(),
            const SizedBox(height: 20),

            // Local Dark Mode Toggle
            SwitchListTile(
              title: Text(darkModeTitle),
              secondary: const Icon(Icons.dark_mode),
              value: _darkMode,
              onChanged: _toggleDarkMode,
            ),


            const Divider(height: 40),

            widget.homePageState.isLogin?ListTile(
              leading: const Icon(Icons.lock),
              title: Text(changedPasswordTitle),
              onTap: () {},
            ):Container(),

            SwitchListTile(
              title: Text(notificationSettingsTitle),
              secondary: const Icon(Icons.notifications),
              value: _onNotification,
              onChanged: (val) {
                setState(() => _onNotification = val);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text(helpSupportTitle),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HelpSupportPage(),
                  ),
                );
              },
            ),

            const Divider(height: 40),

            widget.homePageState.isLogin?ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(menuCPanelUserLogoutTitle, style: const TextStyle(color: Colors.red)),
              onTap: () {
                _userLogout(context, widget.homePageState);
                // Navigator.pop(context);
              },
            ):Container(),
          ],
        ),
      ),
    );
  }
}
