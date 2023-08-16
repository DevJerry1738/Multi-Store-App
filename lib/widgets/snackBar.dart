import 'package:flutter/material.dart';

class MyMessage {
  static void showSnackBar(var _ScaffoldKey, String message) {
    _ScaffoldKey.currentState!.hideCurrentSnackBar();
    _ScaffoldKey.currentState?.showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.white70,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        )));
  }
}
