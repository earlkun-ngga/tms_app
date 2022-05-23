import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;

class Version {


  String currentVersion = '1.0.0.43';

  Future getInfoLastVersion() async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/mobile-config/getOne/1'));
    var data = json.decode(response.body);
    return data;
  }

  Future getInfoIDDownload() async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/mobile-config/getOne/2'));
    var data = json.decode(response.body);
    return data;
  }

}