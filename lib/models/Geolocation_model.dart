import 'dart:ffi';
import 'dart:math' show cos, sqrt, asin;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;


class GeolocationModel {

  late String namalokasi;

  // Future hitungMTK(Double lon1) async{
  //   Double lon;
  //   lon = lon1;
  //   return lon;
  // }


  // Future testMengembalikanNilaiDouble(Double nilai) async {
  //   return nilai;
  // }



  Future getDataLocationAll() async{

    var response = await http.post(Uri.parse('${apiconf.urlApi}api/location/getAll'), body: {
    });
    var dataloctall = json.decode(response.body);
    return dataloctall;


  }



  Future getScanValidationCheckLocation(String codeqr) async {

    var response = await http.get(Uri.parse('${apiconf.urlApi}api/location/getScanValidation/${codeqr}'));
    var datascanvalidation = json.decode(response.body);
    return datascanvalidation;



  }

  void getDataTerdekat() async{

    var response = await http.post(Uri.parse('${apiconf.urlApi}api/location/getAll'), body: {
    });
    var dataloctall = json.decode(response.body);
 
    
   for(var dataloop in dataloctall['data'])
    {
      if(dataloctall['id'] == '1')
      {
        this.namalokasi = dataloctall['nama'].toString();
      }
    }

   
  }

  

}