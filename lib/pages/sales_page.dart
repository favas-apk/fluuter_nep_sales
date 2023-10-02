import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';







import 'dart:convert' as convert;


import '../commons/Colorss.dart';
import '../commons/Constants.dart';
import '../commons/ProjectFunction.dart';




class SalesPage extends StatefulWidget {



  @override
  State<SalesPage> createState() => _MyPageState();
}

class _MyPageState extends State<SalesPage> {
  bool loading = false;
  late DateTime _from_date, _to_date;

List<String> _list_staff=["favas","fazal","manna","janna","fazalurahman"];


  @override
  void initState() {
    DateTime now = DateTime.now();


    _from_date =  DateTime( now.year,now.month,now.day);
    _to_date =   DateTime( now.year,now.month,now.day,);
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return (

        Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
                        child:const Text('From')),



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

                                        // print("Your Selected Date: ${newDateTime.day}");
                                        setState(() => _from_date = newDateTime);
                                      }
                                    },
                                  ),
                                );
                              },
                            );


                          },
                          child: Text(ConvertDate_from_yyyymmdd_to_ddmmyyyy(_from_date.toString().substring(0,10),monthNameNeeded: false),style: TextStyle(color: Colorss.nepton1,fontSize: 16,fontWeight: FontWeight.bold),)
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
                          child: Text(ConvertDate_from_yyyymmdd_to_ddmmyyyy(_to_date.toString().substring(0,10),monthNameNeeded: false),style: TextStyle(color: Colorss.nepton1,fontSize: 16,fontWeight: FontWeight.bold),)
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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              Container(decoration:  borderTLRDecWthBgColor(),width: 150,height: 30,child: const Center(child: Text("LEAD",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)),),
              Container(decoration: borderTLRDecWthBgColor(),width: 150,height:30,child: const Center(child: Text("DEMO",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),
              Container(decoration: borderTLRDecWthBgColor(),width: 150,   height:30,child: const Center(child: Text("IMPLEMENTATION",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),
              Container(decoration:borderTLRDecWthBgColor() ,width: 150,  height:30,child: const Center(child: Text("INVOICE PENDING",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),
              Container(decoration: borderTLRDecWthBgColor(),width: 150,  height:30,child: const Center(child: Text("CLOSED",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),
              Container(decoration: borderTLRDecWthBgColor(),width: 150, height: 30,  child: const Center(child: Text("DECLINED",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),
              const SizedBox(height: 30,),
              Container(decoration: borderTLRDecWthBgColor(),width: 150,height:30,child: const Center(child: Text("SUCCESS RATE",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),
              Container(decoration: borderTLRDecWthBgColor(),width: 150,  height:30,child: const Center(child: Text("DECLINE RATE",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),

             const SizedBox(height: 30,),
             Container(decoration: BorderDecWthBgColor(),width: 150,height:30,child: const Center(child: Text("AVG CLOSING TIME",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),),
            ],
            ),

            SizedBox(

              width:MediaQuery.of(context).size.width * 0.5 ,
              height: 430,


              child:  NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow(); // Disable the blue glow effect
                  return true;
                },

                child: ListView.builder(

                    padding: EdgeInsets.zero,
                    itemCount: _list_staff.length,
                    scrollDirection: Axis.horizontal,


                    itemBuilder: (BuildContext ctx, index) {



                      return  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(



                            width: 60,height: 100,


                            alignment: Alignment.center,
                            decoration: borderTBLDecWthBgColor(),




                            child:  Transform.rotate(angle: 270*(Constants.pi/180),child: Text((_list_staff[index]).toString(),style:  const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRDec(),


                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),
                         const   SizedBox(



                            width: 60,height: 30,




                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRTDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),

                          const   SizedBox(



                            width: 60,height: 30,




                          ),
                          Container(



                            width: 60,height: 30,


                            alignment: Alignment.center,
                            decoration: borderBRTDec(),

                            child:  Text(("1").toString(),style:  TextStyle(color: Colors.black,fontFamily: 'Times',fontSize: 18),),
                          ),

                        ],
                      );


                    }





                ),
              ),
            ),

          ],
        ),

      ],
        )
      ),
    ));
  }
}
