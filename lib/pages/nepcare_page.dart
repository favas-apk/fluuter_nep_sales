import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';








import 'dart:convert' as convert;


import '../commons/Colorss.dart';
import '../commons/Constants.dart';
import '../commons/ProjectFunction.dart';




class NepCarePage extends StatefulWidget {



  @override
  State<NepCarePage> createState() => _MyPageState();
}

class _MyPageState extends State<NepCarePage> {
  bool loading = false;
  late DateTime _from_date, _to_date;



@override
  void initState() {
  DateTime now = DateTime.now();


  _from_date =  DateTime( now.year,now.month,now.day);
  _to_date =   DateTime( now.year,now.month,now.day,);
    super.initState();
  }


_showDatePicker()
{
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2028)).then((value) {



    setState(() {
      _from_date=value!;
    });
  });

}


  @override
  Widget build(BuildContext context) {
    return (

        Scaffold(
      resizeToAvoidBottomInset: true,
      body:
      SingleChildScrollView(
        child:
          Column(
            children: [
              SizedBox(
                height:  MediaQuery.of(context).size.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.blueGrey,
                            width: 0.7,
                          ),
                        )

                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),

                      child: Row(

                        children: [

                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.18,
                              child:InkWell(
                                  onTap: (){

          _showDatePicker();

                                  },
                                  child: const Text('From'))),



                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.30,

                            child:
                            InkWell(
                                onTap: (){



                                  showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return buildBottomPicker(context,
                                        CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          initialDateTime: _from_date,



                                          onDateTimeChanged: (DateTime newDateTime) {
                                            if (mounted) {


                                              setState(() => _from_date = newDateTime);
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  );


                                },
                                child: Text(ConvertDate_from_yyyymmdd_to_ddmmyyyy(_from_date.toString().substring(0,10),monthNameNeeded: false),style: const TextStyle(color: Colorss.nepton1,fontSize: 16,fontWeight: FontWeight.bold),)
                            ),
                          ),

                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: const Text('To')),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.30,

                            child:
                            InkWell(
                                onTap: (){



                                  showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return buildBottomPicker(context,
                                        CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          initialDateTime: _to_date,

                                          onDateTimeChanged: (DateTime newDateTime) {
                                            if (mounted) {


                                              setState(() => _to_date = newDateTime);
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  );


                                },
                                child: Text(ConvertDate_from_yyyymmdd_to_ddmmyyyy(_to_date.toString().substring(0,10),monthNameNeeded: false),style: const TextStyle(color: Colorss.nepton1,fontSize: 16,fontWeight: FontWeight.bold),)
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: 100,),

                  Container(width: 60,height: 100,
                    color: Colorss.nepton1,
                    child: Transform.rotate(    angle: 270*(Constants.pi/180),
                        child: const Center(child: Text("NEW",style: TextStyle(fontFamily: 'Mont',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),))),),
                  Container(width: 60,height: 100,
                    color: Colorss.nepton1,
                    child: Transform.rotate(    angle: 270*(Constants.pi/180),
                        child: const Center(child: Text("SUBSCRIPTION",style: TextStyle(fontFamily:'Mont',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),))),),
                  Container(width: 60,height: 100,
                    color: Colorss.nepton1,
                    child: Transform.rotate(    angle: 270*(Constants.pi/180),
                        child: const Center(child: Text("PAY ON DEMAND",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),))),),
                  Container(width: 60,height: 100,
                    color: Colorss.nepton1,
                    child: Transform.rotate(    angle: 270*(Constants.pi/180),
                        child: const Center(child: Text("TOTAL",  textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),))),),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
               const SizedBox(width: 100, height: 50,
                      child: Center(child: Text("CLOSED TICKETS",textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                      )
                    ),
                    child: const Center(child: Text("123",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("12",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, height: 50,
                    child: Center(child: Text("WIP", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, height: 50,
                    child: Center(child: Text("DUE TICKETS",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, height: 50,
                    child: Center(child: Text("LEVEL 3",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: const Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                ],

              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, height: 50,
                    child: Center(child: Text("CUSTOMER RATING",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                         border: Border(
                           top: BorderSide(width: 1,color: Colors.white),
                           bottom: BorderSide(width: 1,color: Colors.white),
                           left: BorderSide(width: 1,color: Colors.white),
                         ),
                        color: Colorss.nepton2

                    ),
                    child: const Center(child: Text("Excellent",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                     border: Border(
                       top: BorderSide(width: 1,color: Colors.white),
                       bottom: BorderSide(width: 1,color: Colors.white),
                       left: BorderSide(width: 1,color: Colors.white),
                     ),
                        color: Colorss.nepton2
                    ),
                    child: const Center(child: Text("Good",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration:  BoxDecoration(
                        border: Border.all(width: 1,color: Colors.white),
                        color: Colorss.nepton2
                    ),
                    child: const Center(child: Text("Other",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)),

                  ),

                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, height: 50,

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1,color: Colorss.nepton2),

                        left: BorderSide(width: 1,color: Colorss.nepton2),
                      ),
                    ),
                    child: const Center(child: Text("2%",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1,color: Colorss.nepton2),

                        left: BorderSide(width: 1,color: Colorss.nepton2),
                      ),
                    ),
                    child: const Center(child: Text("3%",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1,color: Colorss.nepton2),
                        right: BorderSide(width: 1,color: Colorss.nepton2),

                        left: BorderSide(width: 1,color: Colorss.nepton2),
                      ),
                    ),
                    child: const Center(child: Text("4%",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                ],

              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, height: 50,
                    child: Center(child: Text("EFFICIENCY RATIO", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                     //   border: Border.all(width: 1,color: Colorss.nepton1),
                      color: Colors.red
                    ),
                    child: const Center(child: Text("55%",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),

                  ),


                ],

              ),

            ],
          )

      ),
    ));
  }
}
