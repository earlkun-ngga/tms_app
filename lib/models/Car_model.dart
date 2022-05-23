import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;

class CarModel {
  Future getInfoCarByQrCode(String valueBarcode) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/car/getOneByScan/${valueBarcode}'));
    var datacar = json.decode(response.body);
    return datacar;
  }


  Future getInfoCarById(String idCar) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/car/getOne/${idCar}'));
    var datacar = json.decode(response.body);
    return datacar;
  }

    Future getInfoTrailerById(String idTrailer) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/chasis/getOne/${idTrailer}'));
    var datacar = json.decode(response.body);
    return datacar;
  }
  Future getInfoTrailerByQrCode(String valueBarcode) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/chasis/getOneByScan/${valueBarcode}'));
    var datacar = json.decode(response.body);
    return datacar;
  }
  Future getInfoTireCar(String id_car) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/maintenance/getManufactureAndTire/${id_car}/01'));
    var datacar = json.decode(response.body);
    return datacar;
  }
  Future getInfoTireTrailer(String id_trailer) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/maintenance/getManufactureAndTire/${id_trailer}/02'));
    var datacar = json.decode(response.body);
    return datacar;
  }
}