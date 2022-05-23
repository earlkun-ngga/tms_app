import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;
import 'package:tms_app_mobile/models/Waktu_model.dart';


class TripModel {

  WaktuModel waktumod = WaktuModel();

  Future getStreamTripByIdDriverOne(String driverId) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/driver-car-match/getPendingOrder/${driverId}'));
    var datastream = json.decode(response.body);
    return datastream;
  }

  //STEP TRIP

  Future updateStatusTripFinish(String trip_id) async {
    final response = await http.put(Uri.parse('${apiconf.urlApi}api/trip/update'),
    body: {
      "trip[id]" : "${trip_id}",
      "trip[finish_time]" : "${this.waktumod.getTanggalSecondFormat()}",
      "trip[status]" : "08"
    });
  }

  
  Future updateStatusTripEnd(String trip_id) async {
    final response = await http.put(Uri.parse('${apiconf.urlApi}api/trip/update'),
    body: {
      "trip[id]" : "${trip_id}",
      "trip[in_time]" : "${this.waktumod.getTanggalSecondFormat()}",
      "trip[status]" : "07"
    });
  }


    Future updateStatusTripStart(String trip_id) async {
    final response = await http.put(Uri.parse('${apiconf.urlApi}api/trip/update'),
    body: {
      "trip[id]" : "${trip_id}",
      "trip[out_time]" : "${this.waktumod.getTanggalSecondFormat()}",
      "trip[status]" : "05"
    });
  }

  

  Future updateStatusTripReject(String trip_id) async {
    final response = await http.put(Uri.parse('${apiconf.urlApi}api/trip/update'),
    body: {
      "trip[id]" : "${trip_id}",
      "trip[confirm_time]" : "${this.waktumod.getTanggalSecondFormat()}",
      "trip[status]" : "03"
    });
  }

  Future updateStatusTripAccept(String trip_id) async {
    final response = await http.put(Uri.parse('${apiconf.urlApi}api/trip/update'),
    body: {
      "trip[id]" : "${trip_id}",
      "trip[confirm_time]" : "${this.waktumod.getTanggalSecondFormat()}",
      "trip[status]" : "02"
    });
  }

  Future getOneCurrentTrip(String trip_id) async {
    final response = await http.get(Uri.parse('${apiconf.urlApi}api/trip/getOne/${trip_id}'));
    var datacurrenttrip = json.decode(response.body);
    return datacurrenttrip;
  }
  Future getOneCurrentTripByIdDriver(String idDriver) async {
    final response = await http.get(Uri.parse('${apiconf.urlApi}api/trip/getCurrentTripByDriver/${idDriver}'));
    var datacurrenttrip = json.decode(response.body);
    return datacurrenttrip;
  }

   Future getOneTripById(String trip_id) async {
    final response = await http.get(Uri.parse('${apiconf.urlApi}api/trip/getOne/${trip_id}'));
    var datacurrenttrip = json.decode(response.body);
    return datacurrenttrip;
  }

  Future getCountTripByIdDriverCurrentMonth(String driver_id) async {
    final response = await http.get(Uri.parse('${apiconf.urlApi}/api/trip/getHistoryTripCountDriver/${driver_id}'));
    var datacounttrip = json.decode(response.body);
    return datacounttrip;


  }


  Future tesGetStreamTripLocalServer() async {
    var response =  await http.get(Uri.parse('${apiconf.urlLocalServer}api/get_data_pending_order_test_ktms.php'));
    var dataapi = json.decode(response.body);
    return dataapi;
  }


  Future getHistoryTripByIdDriver(String idDriver) async {

    var response = await http.get(Uri.parse('${apiconf.urlApi}api/trip/getHistoryTripByDriver/${idDriver}'));
    var datahistorytrip = json.decode(response.body);
    return datahistorytrip;
  }

}