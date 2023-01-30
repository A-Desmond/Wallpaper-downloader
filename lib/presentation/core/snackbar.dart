import 'package:flutter/material.dart';

class ShowSnackBar {
  showAlert({
    required BuildContext context,
    required String message,
    required bool error,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: error ? Colors.red : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20,
        ),
      ));
}
