import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Colorss.dart';

dynamic BorderDec()
{
  return BoxDecoration(border: Border.all(width: 1,color: Colorss.nepton1),);
}

dynamic BorderDecWthBgColor()
{
  return BoxDecoration(border: Border.all(width: 1,color: Colors.white),color: Colorss.nepton1);
}

dynamic borderTLRDecWthBgColor()
{
  return const BoxDecoration(border: Border(
      left: BorderSide(color: Colors.white,width: 1),
      right: BorderSide(color: Colors.white,width: 1),
      top: BorderSide(color: Colors.white,width: 1),

  ),color: Colorss.nepton1);
}


dynamic borderTBLDecWthBgColor()
{
  return const BoxDecoration(border: Border(
    left: BorderSide(color: Colors.white,width: 1),
    bottom: BorderSide(color: Colors.white,width: 1),
    top: BorderSide(color: Colors.white,width: 1),

  ),color: Colorss.nepton1);
}


dynamic borderBRDec()
{
  return const BoxDecoration(border: Border(
    right: BorderSide(color: Colorss.nepton1,width: 1),
    bottom: BorderSide(color: Colorss.nepton1,width: 1),


  ),);
}

dynamic borderBRTDec()
{
  return const BoxDecoration(border: Border(
    right: BorderSide(color: Colorss.nepton1,width: 1),
    bottom: BorderSide(color: Colorss.nepton1,width: 1),
    top: BorderSide(color: Colorss.nepton1,width: 1),


  ),);
}


double _kPickerSheetHeight = 216.0;
Widget buildBottomPicker(BuildContext context,Widget picker) {
  return Container(
    height: _kPickerSheetHeight,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {

          Navigator.of(context).pop();
        },
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}


String ConvertDate_from_yyyymmdd_to_ddmmyyyy(String dateStr,{bool monthNameNeeded=true})
{
  String symbol=dateStr.substring(4,5);

  var res= dateStr.split(symbol);


  if(monthNameNeeded)
  {
    return   res[2]+"-"+getMonthName(int.parse(res[1]))+"-"+res[0];
  }
  else
  {
    return   res[2]+"-"+res[1]+"-"+res[0];
  }



}

String getMonthName(int montnNo)
{
  var res='';
  switch(montnNo)
  {
    case 1 : res='January';
    break;

    case 2 : res='February';
    break;

    case 3 : res='March';
    break;

    case 4 : res='April';
    break;

    case 5 : res='May';
    break;

    case 6 : res='June';
    break;

    case 7 : res='July';
    break;

    case 8 : res='August';
    break;

    case 9 : res='September';
    break;

    case 10 : res='October';
    break;

    case 11 : res='November';
    break;

    case 12 : res='December';
    break;



  }

  return res;

}

void showToast(String msg)
{

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}






















