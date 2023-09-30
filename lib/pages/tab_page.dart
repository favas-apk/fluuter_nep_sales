import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_nep_sales/pages/nepcare_page.dart';
import 'package:fluuter_nep_sales/pages/sales_page.dart';

import '../commons/Colorss.dart';









class TabPage extends StatefulWidget {



  @override
  State<TabPage> createState() => _MyPageState();
}

class _MyPageState extends State<TabPage>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this); // Adjust the length as needed
    super.initState();


  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return (

    Scaffold(
      appBar: AppBar(
        backgroundColor: Colorss.nepton1,
        title: const Text(''),
        bottom: TabBar(
          labelColor: Colors.white, // Color for the selected tab
          unselectedLabelColor: Colors.black, // Color for unselected tabs
          controller:  _tabController,
          tabs: const [
            Tab(text: 'Nep Care',),
            Tab(text: 'Sales'),

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [

          // Content for Tab 1

          NepCarePage(),
          // Content for Tab 2

          SalesPage()


        ],
      ),
    )


    );
  }
}
