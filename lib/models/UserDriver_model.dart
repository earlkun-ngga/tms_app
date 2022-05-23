import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;



class UserDriver {
  Future prosesLogin(String usrnameTxt, String passTxt) async {
    final response = await http.post(Uri.parse('${apiconf.urlApi}api/mobile-login'),
    body: {
        "username": usrnameTxt, 
        "password": passTxt
      }
    );
    final datadriver = json.decode(response.body);
    return datadriver;
  }


  Future getStatusAbsent(String driver_id) async {
    final response = await http.get(Uri.parse('${apiconf.urlApi}api/driver-absent/getDriverStatusAbsent/${driver_id}'));
    var dataabsent = json.decode(response.body);
    return dataabsent;

  }

   Future getStatusAbsent2(String driver_id) async {
    final response = await http.get(Uri.parse('${apiconf.urlApi}api/driver-absent/getDriverStatusAbsent/${driver_id}'));
    return response;

  }



  Future getDataDriveById(String driver_id) async {
    final response = await http.get(Uri.parse('${apiconf.urlApi}api/driver/getOne/${driver_id}'));
    var datadriver = json.decode(response.body);
    return datadriver;
  }

  Future prosesLoginV1(String usernameTxt, String passwordTxt) async {
    final response = await http.post(Uri.parse('${apiconf.urlApi}api/mobile-login'),
    body: {
        "username": usernameTxt, 
        "password": passwordTxt
      }
    );
   return response;
  }

  Future getDataUser(String usernameTxt, String passwordTxt) async {
    final response = await http.post(Uri.parse('${apiconf.urlApi}api/mobile-login'),
    body: {
        "username": usernameTxt, 
        "password": passwordTxt
      }
    );
   var datalogin = json.decode(response.body);
   return datalogin;
  }
}