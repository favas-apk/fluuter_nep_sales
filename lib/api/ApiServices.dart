import '../commons/Constants.dart';
import 'ApiConstants.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<dynamic> readSchedule(String db, String dat) async {
    var client = http.Client();
    var response = await client.post(
        Uri.https(ApiConstants.baseUrl, ApiConstants.readScheduleEndpoint),
        body: {
          'db': db,
          'dat': dat,
        });
    return response;
  }

  Future<dynamic> readSales(String db, String fdat,String tdat) async {
    var client = http.Client();
    var response = await client.post(
        Uri.https(ApiConstants.baseUrl, ApiConstants.readSalesEndpoint),
        body: {
          'db': db,
          'fdat': fdat,
          'tdat': tdat,
        });
    return response;
  }


  Future<dynamic> readNepcare(String db, String fdat,String tdat) async {
    var client = http.Client();
    var response = await client.post(
        Uri.https(ApiConstants.baseUrl, ApiConstants.readNepCareEndpoint),
        body: {
          'db': db,
          'fdat': fdat,
          'tdat': tdat,
        });
    return response;
  }


  Future<dynamic> doLogin( String unam,String pswd) async {
    var client = http.Client();
    var response = await client.post(
        Uri.https(ApiConstants.baseUrl, ApiConstants.loginEndpoint),
        body: {
          'db': 'neptongl_staff',
          'unam': unam,
          'pswd': pswd,
        });
    return response;
  }





}
