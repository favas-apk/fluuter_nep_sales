import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluuter_nep_sales/models/model_schedule.dart';

import '../api/ApiServices.dart';
import '../commons/Colorss.dart';
import '../commons/ProjectFunction.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _first_time = true;

  List<ModelSchedule> _list_sch = [];
  late DateTime _from_date;
  int _sl=0;

  @override
  void initState() {
    DateTime now = DateTime.now();

    _from_date = DateTime(now.year, now.month, now.day);
    super.initState();
  }

  void _init() {
    _read_schedule();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _read_schedule();
    });

  }




  _showDatePicker() {
    DateTime? selectedDate; // Initialize a variable to store the selected date

    showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colorss.nepton1, // Change the header color
              onPrimary: Colors.white54, // Change the "OK" button color
              onSurface: Colorss.nepton2, // Change the background color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colorss.nepton1, // Change the button text color
              ),
            ),
          ),
          child: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppBar(
                  title: const Text('Select a Date'),
                ),
                CalendarDatePicker(
                  onDateChanged: (date) {
                    // Handle date selection
                    selectedDate = date;
                  },
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2028),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle "OK" button press with the selectedDate
                    if (selectedDate != null) {
                      setState(() {
                        _from_date = selectedDate!; // Update your _from_date variable
                        _read_schedule();
                      });
                    }
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2028),
    );
  }




  Future<void> _read_schedule() async {
    _list_sch = [];
    _sl=0;
    var response = await ApiServices()
        .readSchedule("neptongl_staff", _from_date.toString().substring(0, 10));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      var result = jsonResponse["result"];

      if (result == 1) {
        var _details_sch = jsonResponse["details_sch"];

        for (int j = 0; j < _details_sch.length; j++) {
          ModelSchedule modelSchedule = ModelSchedule.fromJson(_details_sch[j]);

          _list_sch.add(modelSchedule);
        }
      }

      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_first_time) {
      _first_time = false;
      _init();
    }
    _sl=0;
    return Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (    overscroll){
            overscroll.disallowIndicator(); // Disable the blue glow effect
            return true;
          },
          child: SingleChildScrollView(
      child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.blueGrey,
                      width: 0.7,
                    ),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: InkWell(
                                onTap: () {
                                  _showDatePicker();
                                },
                                child: const Text('Date'))),





                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: InkWell(
                            onTap: () {
                              _showDatePicker();
                            },
                            child: Text(
                              ConvertDate_from_yyyymmdd_to_ddmmyyyy(
                                  _from_date.toString().substring(0, 10),
                                  monthNameNeeded: false),
                              style: const TextStyle(
                                  color: Colorss.nepton1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colorss.nepton1),
                                // Background color
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                // Text color
                                elevation:
                                    MaterialStateProperty.all(8), // Elevation
                              ),
                              onPressed: () {
                                _read_schedule();

                              },
                              child: const Text("Refresh"),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),



            (_list_sch.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 850,
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              SizedBox(
                                width: double.infinity,
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,

                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          )),
                                      child: const Text(
                                        'sl no',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Mont',
                                            fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,

                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          )),
                                      child: const Text(
                                        'Service Type',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Mont',
                                            fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      width: 100,

                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          )),
                                      child: const Text(
                                        'Employ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Mont',
                                            fontSize: 18),
                                      ),
                                    ),

                                    Container(
                                      width: 100,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          )),
                                      child: const Text(
                                        'Area',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Mont',
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          )),
                                      child: const Text(
                                        'Customer',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Mont',
                                            fontSize: 18),
                                      ),
                                    ),

                                    Container(
                                      width: 200,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          )),
                                      child: const Text(
                                        'Call Details',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Mont',
                                            fontSize: 18),
                                      ),
                                    ),



                                    Container(
                                      width: 100,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          )),
                                      child: const Text(
                                        'Status',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Mont',
                                            fontSize: 18),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.60,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: _list_sch.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext ctx, index) {

                                      if(index>0)
                                        {
                                          if(_list_sch[index-1].staff==_list_sch[index].staff)
                                            {
                                              _sl=_sl+1;
                                            }
                                          else
                                            {
                                              _sl=1;
                                            }

                                        }
                                      else
                                        {
                                          _sl=_sl+1;
                                        }


                                      return Container(
                                        constraints: const BoxConstraints(
                                            minHeight: 50,
                                            minWidth: double.infinity),
                                        decoration:  BoxDecoration(
                                            color:   index%2==0?Colors.white: Colorss.ivory_shade1,
                                            border: const Border(
                                              top: BorderSide(
                                                color: Colors.grey,
                                                width: .25,
                                              ),
                                            )),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.grey,
                                                      width: .25,
                                                    ),
                                                  )),



                                              child: Text((index+1).toString(),

                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont',
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.grey,
                                                      width: .25,
                                                    ),
                                                  )),



                                              child: const Text("Demo",

                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont',
                                                    fontSize: 18),
                                              ),
                                            ),


                                            Container(
                                              width:100,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                right: BorderSide(
                                                  color: Colors.grey,
                                                  width: .25,
                                                ),
                                              )),
                                              child: Text(
                                               toCamelCase( _list_sch[index].staff.toString()),

                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont',
                                                    fontSize: 18),
                                              ),
                                            ),


                                            Container(
                                              width:100,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.grey,
                                                      width: .25,
                                                    ),
                                                  )),
                                              child: Text("",


                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Times',
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Container(
                                              width:200,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.grey,
                                                      width: .25,
                                                    ),
                                                  )),
                                              child: Text(
                                               toCamelCase( _list_sch[index].cus.toString()),
                                                textAlign: TextAlign.center,

                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont',
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Container(
                                              width:200,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.grey,
                                                      width: .25,
                                                    ),
                                                  )),
                                              child: Text(
                                                toCamelCase(_list_sch[index].desp.toString()),
                                                textAlign: TextAlign.center,

                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont',
                                                    fontSize: 18),
                                              ),
                                            ),


                                            Container(
                                              width:100,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.grey,
                                                      width: .25,
                                                    ),
                                                  )),
                                              child: Text(
                                               toCamelCase( _list_sch[index].st.toString()),

                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont',
                                                    fontSize: 18),
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox())
          ],
      ),
    ),
        ));
  }
}
