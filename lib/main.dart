// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_library_mobile/screens/home_screen.dart';
import 'package:tech_library_mobile/screens/login_screen.dart';
import 'package:tech_library_mobile/screens/wait_screen.dart';
import 'models/token.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _showLoginPage = true;
  late Token _token;

  @override
  void initState() {
    super.initState();
    _getHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechLibrary App',
      home: _isLoading
          ? WaitScreen()
          : _showLoginPage
              ? LoginScreen()
              : HomeScreen(token: _token),
    );
  }

  void _getHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRemembered = prefs.getBool('isRemembered') ?? false;
    if (isRemembered) {
      String? userBody = prefs.getString('userBody');
      if (userBody != null) {
        var decodedJson = jsonDecode(userBody);
        _token = Token.fromJson(decodedJson);
        if (DateTime.parse(_token.expiracion).isAfter(DateTime.now())) {
          _showLoginPage = false;
        }
      }
    }

    _isLoading = false;
    setState(() {});
  }
}
