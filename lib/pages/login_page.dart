import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';







import 'dart:convert' as convert;


import '../commons/Colorss.dart';
import '../commons/Constants.dart';
import '../commons/ProjectFunction.dart';




class LoginPage extends StatefulWidget {



  @override
  State<LoginPage> createState() => _MyPageState();
}

class _MyPageState extends State<LoginPage> {
  bool loading = false;

  final _txt_username_controller = TextEditingController();
  final _txt_password_controller = TextEditingController();




//   void _do_login(String username, String temp_pswd) async {
//     setState(() {
//       loading = true;
//     });
//
//
//
//     final prefs = await SharedPreferences.getInstance();
// //    final String? _deviceID = prefs.getString('deviceID');
//
//     final String? selectedCompanyCode = prefs.getString('selectedCompanyCode');
//     final String? selectedCompanyDB = prefs.getString('selectedCompanyDB');
//     final String?   _device_perm = prefs.getString('device_perm');
//
//
//
//    var db=  await openDatabase(selectedCompanyCode!);
//
//
//
//
//
//
//       late final _userPermDao;
//
//
//
//       var response = await ApiServices().doLogin(selectedCompanyDB!, username);
//
//       if (response.statusCode == 200) {
//         var jsonResponse =
//             convert.jsonDecode(response.body) as Map<String, dynamic>;
//         //
//         var result = jsonResponse["result"];
//         if(result=="1")
//           {
//             var nextno = jsonResponse["nextno"];
//
//             FToast.toast(context,msg: "saved");
//           }
//
//
//         setState(() {
//           loading = false;
//         });
//
//         if (result.toString() == "1") {
//           var _userId = jsonResponse["user_id"];
//           var _pswd = jsonResponse["pswd"];
//           var _utype = jsonResponse["u_type"];
//
//
// var  _accessed_fid = jsonResponse["accessed_fid"];
// var  _id = jsonResponse["id"];
//
//
//
//           if (sha_encode(temp_pswd) == _pswd) {
//             await prefs.setString('logedin_userid', _userId.toString());
//             await prefs.setString('logedin_username', username);
//             await prefs.setString('logedin_u_type', _utype);
//             await prefs.setString('selected_bra_str',_accessed_fid);
//             await prefs.setString('logedin_id',_id);
//
//
//             await db.execute('Delete  FROM tbl_user_permission');
//             response = await ApiServices()
//                 .getUserPermission(selectedCompanyDB, _userId, );
//
//             if (response.statusCode == 200) {
//               var jsonResponse =
//                   convert.jsonDecode(response.body) as Map<String, dynamic>;
//
//               var details_user_perm = jsonResponse["user_perm"];
//
//               var sze = details_user_perm.length;
//
//               for(int j=0;j<sze;j++)
//                 {
//                         await db.transaction((txn) async {
//                           int id1 = await txn.rawInsert(
//                               "INSERT INTO tbl_user_permission(perm_no,perm_st) VALUES('${details_user_perm[j]["perm_no"]}', '${details_user_perm[j]["status"]}')");
//                       });
//                 }
//
//               await prefs.setString('unam', _txt_username_controller.text.trim());
//               await prefs.setString('upswd', _txt_password_controller.text.trim());
//
//               jumb_to_homepage(context);
//
//
//
//
//
//               setState(() {
//                 loading = false;
//               });
//
//
//             }
//           } else {
//             FToast.toast(context, msg: "Wrong Password ");
//
//             setState(() {
//               loading = false;
//             });
//           }
//         } else {
//           FToast.toast(context, msg: "Invalid username");
//
//           setState(() {
//             loading = false;
//           });
//         }
//       } else {
//         setState(() {
//           loading = false;
//         });
//       }
//
//   }

  @override
  Widget build(BuildContext context) {
    return (

        Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 250,
                decoration:  const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colorss.nepton1, Colorss.nepton2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            // String path=await getSelectedDbPath();
                            // Share.shareFiles([path]);
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: AssetImage('images/icon.png'),
                                )
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            ' v ${Constants.app_ver}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child:
                TextField(
                  controller: _txt_username_controller,
                  onChanged: (String value) {
                    setState(() {});
                  },
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      prefixText: '   ',
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                _txt_username_controller.text.trim().length > 0
                                    ? Colors.green
                                    : Colors.red,
                            width: 1),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      hintStyle: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      suffixIcon: const Icon(
                        Icons.person,
                        color: Colors.blueGrey,
                        size: 20.0,
                      ),
                      labelText: '     Username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                child: TextField(
                  controller: _txt_password_controller,
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {});
                  },
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      prefixText: '   ',
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                _txt_password_controller.text.trim().length > 0
                                    ? Colors.green
                                    : Colors.red,
                            width: 1),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      hintStyle: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      suffixIcon: const Icon(
                        Icons.lock,
                        color: Colors.blueGrey,
                        size: 20.0,
                      ),
                      labelText: '     Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28, left: 5, right: 5),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colorss.nepton1, Colorss.nepton2],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),

                        minimumSize: const Size.fromHeight(40), // NEW
                      ),
                      onPressed: () {
                        if (_txt_username_controller.text.trim().length == 0 ||
                            _txt_password_controller.text.trim().length == 0) {

                          showToast("Please Enter Username and Password ");


                 //         return;
                        }

                        if (loading) {
                          return;
                        }

                    //    _do_login(_txt_username_controller.text.trim(), _txt_password_controller.text.trim());

                        // CommonFunctions.showToast(_get_real_id().toString());
                      },
                      child: Stack(children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'NEXT',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: loading == true
                              ? Transform.scale(
                                  scale: 0.7,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ))
                              : null,
                        )
                      ])
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.black),
                      ))),
              const Padding(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'POWERED BY',
                        style: TextStyle(color: Colors.blueGrey),
                      ))),
              const Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      width: 170,
                      child: Image(
                          image: AssetImage('images/appicon.png'),
                          fit: BoxFit.fill)
                  )
              )
            ],
          ),
        ),
      ),
    ));
  }
}
