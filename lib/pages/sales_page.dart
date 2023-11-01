import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../api/ApiServices.dart';
import '../commons/Colorss.dart';
import '../commons/Constants.dart';
import '../commons/ProjectFunction.dart';
import '../models/model_sales.dart';

class SalesPage extends StatefulWidget {
  @override
  State<SalesPage> createState() => _MyPageState();
}

class _MyPageState extends State<SalesPage> {
  bool loading = false;
  late DateTime _from_date, _to_date;

  bool _first_time = true;

  List<ModelSales> _list_sales = [];
  var _details_avg = [];

  @override
  void initState() {
    DateTime now = DateTime.now();

    _from_date = DateTime(now.year, now.month, now.day);
    _to_date = DateTime(
      now.year,
      now.month,
      now.day,
    );
    super.initState();
  }

  String getEstName(String est) {
    String res = "";
    switch (est) {
      case "0":
        res = "Lead";
        break;

      case "1":
        res = "Demo";
        break;

      case "2":
        res = "Implementation";
        break;

      case "3":
        res = "Check List Pending";
        break;

      case "4":
        res = "Payment Pending";
        break;

      case "5":
        res = "Completed";
        break;

      case "6":
        res = "Declined";
        break;

      case "7":
        res = "Follow up";
        break;
    }

    return res;
  }

  Future<String> _gettotDaysofEmp(String staffid) async
  {

          String res="";
          for(int j=0;j<_details_avg.length;j++)
            {
              if(_details_avg[j]["staffid"]== staffid)
                {
                  res=_details_avg[j]["tot_days"];
                }


            }



    return res;
  }


  Future<void> _read_sales() async {
    _list_sales = [];

    var response = await ApiServices().readSales(
        "neptongl_staff",
        _from_date.toString().substring(0, 10),
        _to_date.toString().substring(0, 10));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      var result = jsonResponse["result"];

      if (result == 1) {
        var _details_sales = jsonResponse["details_sales"];
        _details_avg = jsonResponse["details_avg"];



        var lead = "",
            demo = "0",
            imp = "0",
            c_pend = "0",
            p_pend = "0",
            comp = "0",
            decl = "0",
            follow = "0",
        staffid="0";
        var pre_emp = "",pre_staffid="";
        var tot_cllosed_cnt = 0;


        for (int j = 0; j < _details_sales.length; j++) {
          var emp = _details_sales[j]["staff"];
          var staffid = _details_sales[j]["staffid"];

          if (pre_emp == "" || pre_emp == emp) {
            var est = _details_sales[j]["est"];

            var cnt = _details_sales[j]["cnt"];

            if (est == "0") {
              lead = cnt;
            } else if (est == "1") {
              demo = cnt;
            } else if (est == "2") {
              imp = cnt;
            } else if (est == "3") {
              c_pend = cnt;
            } else if (est == "4") {
              p_pend = cnt;
            } else if (est == "5") {
              comp = cnt;
              tot_cllosed_cnt = tot_cllosed_cnt + int.parse(comp);
            } else if (est == "6") {
              decl = cnt;
            }

            pre_emp = emp;
            pre_staffid=staffid;
          } else {


            int tot_p = int.parse(c_pend) + int.parse(p_pend);

        var tot_days=   await  _gettotDaysofEmp(pre_staffid );

            ModelSales modelSales = ModelSales(
                staff: pre_emp,
                lead: (lead+demo+imp+comp),
                demo: (demo+imp+comp),
                imp:( imp+comp),
                pend: tot_p.toString(),
                closed: comp,
                declined: decl,
              tot_days: tot_days

            );


            _list_sales.add(modelSales);
            staffid="0";
            lead = "0";
            demo = "0";
            imp = "0";
            c_pend = "0";
            p_pend = "0";
            comp = "0";
            decl = "0";
            pre_emp = "";

            var est = _details_sales[j]["est"];

            var cnt = _details_sales[j]["cnt"];

            if (est == "0") {
              lead = cnt;
            } else if (est == "1") {
              demo = cnt;
            } else if (est == "2") {
              imp = cnt;
            } else if (est == "3") {
              c_pend = cnt;
            } else if (est == "4") {
              p_pend = cnt;
            } else if (est == "5") {
              comp = cnt;
              tot_cllosed_cnt = tot_cllosed_cnt + int.parse(comp);
            } else if (est == "6") {
              decl = cnt;
            }

            pre_emp = emp;
            pre_staffid=staffid;
          }


        }
      }

      //    print("tot is ${_list_sales.}");
      setState(() {});
    }
  }

  Future<void> _init() async {
    await _read_sales();

  }

  @override
  Widget build(BuildContext context) {
    if (_first_time) {
      _first_time = false;
      _init();
    }

    return (Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.18,
                          child: const Text('From')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: InkWell(
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return buildBottomPicker(
                                    context,
                                    CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: _from_date,
                                      onDateTimeChanged:
                                          (DateTime newDateTime) async {
                                        if (mounted) {
                                          _from_date = newDateTime;
                                          _list_sales.clear();

                                          await _read_sales();
                                          // print("Your Selected Date: ${newDateTime.day}");
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              ConvertDate_from_yyyymmdd_to_ddmmyyyy(
                                  _from_date.toString().substring(0, 10),
                                  monthNameNeeded: false),
                              style: const TextStyle(
                                  color: Colorss.nepton1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: const Text('To')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: InkWell(
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return buildBottomPicker(
                                    context,
                                    CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: _to_date,
                                      onDateTimeChanged:
                                          (DateTime newDateTime) async {
                                        if (mounted) {
                                          if (newDateTime
                                              .isBefore(_from_date)) {
                                            showToast(
                                                "Please choose a date ie higher than  'From Date' ");
                                            return;
                                          }
                                          _to_date = newDateTime;


                                          await _read_sales();
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              ConvertDate_from_yyyymmdd_to_ddmmyyyy(
                                  _to_date.toString().substring(0, 10),
                                  monthNameNeeded: false),
                              style: const TextStyle(
                                  color: Colorss.nepton1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "LEAD",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "DEMO",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "IMPLEMENTATION",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "INVOICE PENDING",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "CLOSED",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "DECLINED",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 30,
                    child: Container(
                      decoration: borderTLRDecWthBgColor(),
                      width: 150,
                      height: 30,
                      child: const Center(
                          child: Text(
                        "SUCCESS RATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "LEAD-CLOSE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "DEMO-CLOSE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 30,
                    child: Container(
                      decoration: borderTLRDecWthBgColor(),
                      width: 150,
                      height: 30,
                      child: const Center(
                          child: Text(
                        "DECLINE RATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "LEAD-DECLINE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "DEMO-DECLINE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BorderDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "AVG CLOSING TIME",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: borderTLRDecWthBgColor(),
                    width: 150,
                    height: 30,
                    child: const Center(
                        child: Text(
                      "LEAD-CLOSE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 610,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _list_sales.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: borderTBLDecWthBgColor(),
                            child: Transform.rotate(
                                angle: 270 * (Constants.pi / 180),
                                child: Text(
                                  (toCamelCase(_list_sales[index].staff!)),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              (_list_sales[index].lead).toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              (_list_sales[index].demo).toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              (_list_sales[index].imp).toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              (_list_sales[index].pend).toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              (_list_sales[index].closed).toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              (_list_sales[index].declined).toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 60,
                            height: 30,
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRTDec(),
                            child: Text("${((int.parse(_list_sales[index].closed!) / int.parse(_list_sales[index].lead!)) * 100).toStringAsFixed(1)}%",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              "${((int.parse(_list_sales[index].closed!) / int.parse(_list_sales[index].demo!)) * 100).toStringAsFixed(0)}%",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 60,
                            height: 30,
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRTDec(),
                            child: Text(
                              "${((int.parse(_list_sales[index].declined!) / int.parse(_list_sales[index].lead!)) * 100).toStringAsFixed(1)}%",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRDec(),
                            child: Text(
                              "${((int.parse(_list_sales[index].declined!) / int.parse(_list_sales[index].demo!)) * 100).toStringAsFixed(1)}%",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 60,
                            height: 30,
                          ),

                          Container(
                            width: 60,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: borderBRTDec(),
                            child: Text("${((int.parse(_list_sales[index].tot_days!) / int.parse(_list_sales[index].closed!)) ).toStringAsFixed(0)}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Times',
                                  fontSize: 18),
                            ),

                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ],
      )),
    ));
  }
}
