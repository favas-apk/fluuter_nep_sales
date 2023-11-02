import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_nep_sales/pages/login_page.dart';
import 'package:fluuter_nep_sales/pages/nepcare_page.dart';
import 'package:fluuter_nep_sales/pages/sales_page.dart';
import 'package:fluuter_nep_sales/pages/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commons/Colorss.dart';









class TabPage extends StatefulWidget {



  @override
  State<TabPage> createState() => _MyPageState();
}

class _MyPageState extends State<TabPage>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this); // Adjust the length as needed
    super.initState();


  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  _showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();

      },
    );
    Widget continueButton = TextButton(
      child: const Text("Logout"),
      onPressed:  () async {


        final prefs = await SharedPreferences.getInstance();
        prefs.remove("logedin");
        Navigator.of(context, rootNavigator: false).pop();
       // Navigator.of(context, rootNavigator: false).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);








      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: const Text("AlertDialog"),
      content: const Text("Would you like to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );




    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context1) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(

      onNotification: (    overscroll){
        overscroll.disallowIndicator(); // Disable the blue glow effect
        return true;
      },

      child: (

      Scaffold(
        appBar: AppBar(
          backgroundColor: Colorss.nepton1,
          title: const Text('Nepton'),
  actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SizedBox(
          height: 35,
          width: 35,

          child: Center(
            child: RawMaterialButton(

              onPressed: () async {

                _showAlertDialog(context);



              },
              elevation: 2.0,
              fillColor: Colors.green,

              shape: const CircleBorder(),
              child: const Icon(
                Icons.exit_to_app,
                size: 20.0,
                color: Colors.white,

              ),
            ),
          ),
        ),
      ),
  ],
          bottom: TabBar(
            labelColor: Colors.white, // Color for the selected tab
            unselectedLabelColor: Colors.black, // Color for unselected tabs
            controller:  _tabController,
            tabs: const [
              Tab(text: 'Nep Care',),
              Tab(text: 'Sales'),
              Tab(text: 'Schedule'),

            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [

            // Content for Tab 1

            NepCarePage(),
            // Content for Tab 2

            SalesPage(),
            const SchedulePage(),


          ],
        ),
      )


      ),
    );
  }
}
