import 'package:flutter/material.dart';
import 'package:fluuter_nep_sales/pages/tab_page.dart';

import '../pages/login_page.dart';


jumb_to_tab_page(BuildContext context)
{


  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => TabPage()),
  );




}
