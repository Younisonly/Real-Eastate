import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var primaryColor = Color.fromRGBO(130, 137, 234, 1);

 showSnackbar(String title, String message,IconData icon) {
   Get.snackbar(
    icon:
     Icon(icon, color: CupertinoColors.activeGreen),
    title,
    message,
    colorText: Colors.black,
    snackPosition: SnackPosition.BOTTOM,
  );
}