import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;


class LocationModel {


  Future getLocationById(String idLocation) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/location/getOne/${idLocation}'));
    var datalocation = json.decode(response.body);
    return datalocation;

  }

}