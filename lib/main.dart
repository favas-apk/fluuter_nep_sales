import 'package:flutter/material.dart';
import 'package:fluuter_nep_sales/pages/login_page.dart';
import 'package:fluuter_nep_sales/pages/tab_page.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Mont', // Specify the font family here
            // Other theme configurations
          ),
          home:TabPage()));
}

