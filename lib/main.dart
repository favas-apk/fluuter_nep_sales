import 'package:flutter/material.dart';

import 'package:fluuter_nep_sales/pages/login_page.dart';
import 'package:fluuter_nep_sales/pages/tab_page.dart';
import 'package:shared_preferences/shared_preferences.dart';





Future<void> main()
async {

  WidgetsFlutterBinding.ensureInitialized();


  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getString('logedin') == null) ? 'no' : prefs.getString('logedin');


  runApp(MaterialApp(
      home: isLoggedIn=='yes' ?  TabPage(): LoginPage()
  )
  );
}





