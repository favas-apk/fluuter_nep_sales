import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';








import 'dart:convert' as convert;


import '../api/ApiServices.dart';
import '../commons/Colorss.dart';
import '../commons/Constants.dart';
import '../commons/ProjectFunction.dart';
import '../models/model_nepcare.dart';




class NepCarePage extends StatefulWidget {



  @override
  State<NepCarePage> createState() => _MyPageState();
}

class _MyPageState extends State<NepCarePage> {
  bool _first_time = true;
  late DateTime _from_date, _to_date;

DetailsClosed? _details_closed=null;
  DetailsOther? _details_other=null;


@override
  void initState() {
  DateTime now = DateTime.now();


  _from_date =  DateTime( now.year,now.month,now.day);
  _to_date =   DateTime( now.year,now.month,now.day,);
    super.initState();
  }


_showDatePicker(int type)
{
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2028)).then((value) {



    setState(() {

      if(type==1)
        {
          _from_date=value!;
        }
      else
        {
          _to_date=value!;
        }


    });
    _read_nepcare();

  });



}



  Future<void> _read_nepcare() async {
    _details_closed = null;
    _details_other = null;

    var response = await ApiServices().readNepcare("neptongl_staff", _from_date.toString().substring(0, 10), _to_date.toString().substring(0, 10));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      var result = jsonResponse["result"];

      if (result == 1) {

    //    var _details_others = jsonResponse["details_others"];



        _details_closed = DetailsClosed.fromJson(jsonResponse["details_closed"][0]);

     _details_other = DetailsOther.fromJson(jsonResponse["details_others"][0]);





      }

      setState(() {});
    }
  }

  void  _init() async
  {
      await  _read_nepcare();

  }


  @override
  Widget build(BuildContext context) {

  if(_first_time)
    {
      _first_time=false;
    _init();
    }


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

                                      _showDatePicker(1);

                                  },
                                  child: const Text('From'))),



                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.30,

                            child:
                            InkWell(
                                onTap: (){



                                  _showDatePicker(1);


                                },
                                child: Text(ConvertDate_from_yyyymmdd_to_ddmmyyyy(_from_date.toString().substring(0,10),monthNameNeeded: false),style: const TextStyle(color: Colorss.nepton1,fontSize: 16,fontWeight: FontWeight.bold),)
                            ),
                          ),

                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: InkWell(
                                onTap: (){
                                  _showDatePicker(2);
                                },

                                  child: const Text('To'))),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.30,

                            child:
                            InkWell(
                                onTap: (){


                                  _showDatePicker(2);



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
                    child:  Center(child: Text(_details_closed==null? '0' : _details_closed!.cn.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),


                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text(_details_closed==null? '0' : _details_closed!.cs.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text(_details_closed==null? '0' : _details_closed!.cp.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child:
                    Text(  _details_closed==null? '0' : (      int.parse(_details_closed!.cn!) +    int.parse(_details_closed!.cs!) +  int.parse(_details_closed!.cp!)   ).toString() ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                    ),

                  ),
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, height: 50,
                    child: Center(child: Text("OPEN TICKETS", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text( _details_other==null?"0":  _details_other!.wn.toString()    ,   style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text(_details_other==null?"0":  _details_other!.ws.toString() ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text(_details_other==null?"0":  _details_other!.wp.toString() ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text(_details_other==null?"0":   (      int.parse(_details_other!.wn!) +    int.parse(_details_other!.ws!) +  int.parse(_details_other!.wp!)   ).toString() ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

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
                    child:  Center(child: Text(_details_other==null?"0":  _details_other!.dn.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text(_details_other==null?"0":  _details_other!.ds.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text(  _details_other==null?"0":  _details_other!.dp.toString() ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:   Center(child:
                    Text(   _details_other==null?"0":   (      int.parse(_details_other!.dn!) +    int.parse(_details_other!.ds!) +  int.parse(_details_other!.dp!)   ).toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                    ),

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
                    child:  Center(child: Text(  _details_other==null?"0":  _details_other!.ln.toString() ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text( _details_other==null?"0":  _details_other!.ls.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),

                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child:  Center(child: Text( _details_other==null?"0":  _details_other!.lp.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1,color: Colorss.nepton1),
                          right: BorderSide(width: 1,color: Colorss.nepton1),
                          bottom: BorderSide(width: 1,color: Colorss.nepton1),

                        )
                    ),
                    child: Center(child:
                    Text(   _details_other==null?"0":   (      int.parse(_details_other!.ln!) +    int.parse(_details_other!.ls!) +  int.parse(_details_other!.lp!)   ).toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                    ),

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

                  Container(width: 80,height: 50,
                    decoration:  BoxDecoration(
                        border: Border.all(width: 1,color: Colors.white),
                        color: Colorss.nepton2
                    ),
                    child: const Center(child: Text("Uncompleted",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)),

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
                    child:  Center(child:


                       Text(  _details_closed==null? '0' : (     ( (int.parse(_details_closed!.ex!) )  /(int.parse(_details_closed!.cn!) +    int.parse(_details_closed!.cs!) +  int.parse(_details_closed!.cp!)))*100   ).toStringAsFixed(2) ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                    ),

                  ),
                  Container(width: 60,height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1,color: Colorss.nepton2),

                        left: BorderSide(width: 1,color: Colorss.nepton2),
                      ),
                    ),
                    child:  Center(child:

                    Text(  _details_closed==null? '0' : (     ( (int.parse(_details_closed!.gu!) )  /(int.parse(_details_closed!.cn!) +    int.parse(_details_closed!.cs!) +  int.parse(_details_closed!.cp!)))*100   ).toStringAsFixed(2) ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)

                    ),

                  ),

                  Container(width: 80,height: 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1,color: Colorss.nepton2),
                        right: BorderSide(width: 1,color: Colorss.nepton2),

                        left: BorderSide(width: 1,color: Colorss.nepton2),
                      ),
                    ),
                    child:  Center(child:
                    Text(  _details_closed==null? '0' : (     ( (int.parse(_details_closed!.oth!) )  /(int.parse(_details_closed!.cn!) +    int.parse(_details_closed!.cs!) +  int.parse(_details_closed!.cp!)))*100   ).toStringAsFixed(2) ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                    ),

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
                    child:  Center(child:
                    Text(  _details_closed==null? '0' : (     (     (  (int.parse(_details_closed!.cn!) +    int.parse(_details_closed!.cs!) +  int.parse(_details_closed!.cp!))   )  / (int.parse(_details_closed!.efr!) )    )*100   ).toStringAsFixed(2) ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)

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
