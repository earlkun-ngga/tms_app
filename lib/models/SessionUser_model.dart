import 'package:shared_preferences/shared_preferences.dart';

/*
SESSION USER MENYIMPAN DATA
- DATA USERNAME
- DATA PASSWORD
- DATA ID DRIVER
- DATA KETIKA SUDAH ABSENT : 
  -> PLATE NO
  -> BARCODE MOBIL (SAAT ABSENT)
  -> WAKTU ABSENT (TIME ABSENT)
- DATA TRIP : 
  -> ID TRIP (UNTUK CHECK STATUS TRIP, APAKAH ON JOB ATAU TIDAK)
*/
class SessionUser {


  SessionUser();


  Future<String> getDriverID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('id_driver') ?? '';
  }

  Future<String> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('username') ?? '';
  }

  Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('password') ?? '';
  }

  Future<String> getPlateNoCar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('plateno') ?? '';
  }

  Future<String> getIdTrip() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('idtrip') ?? '';
  }


  Future<String> getBarcodeValueDataCar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('barcodevaluedatacar') ?? '';
  }


  Future<String> getTimeAbsent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('timeabsent') ?? '';
  }

  Future<String> getLanguageCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('langcode') ?? '1';
  }
  
  

  //SET


  void setLanguageCode(String id_lang) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('langcode', id_lang);
  }

  void setIdTrip(String idTrip) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('idtrip', idTrip);
  }


  void setBarcodeValueCarData(String barcodeString) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('barcodevaluedatacar', barcodeString);
  }

  void setPlateNo(String plateno) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('plateno', plateno);

  }

  void setDriverId(String id_driver) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('id_driver', id_driver);
  }

  void setPasswordUserSF(String pss) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('password', pss);
  }

  
  void setUsernameUserSF(String usr) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', usr);
  }

  void setTimeAbsent(String time) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('timeabsent', time);
  }

  //DELETE SELECTED DATA
  void setBarcodeValueCarDatatoNull() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('barcodevaluedatacar', '');
  }
  void setPlateNotoNull() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('plateno', '');
  }
  void setTimeAbsentToNull() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('timeabsent', '');
  }

  //CLEAR DATA SHARED PREFERENCES (MAYBE LOGOUT)
  void clearDataSF() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }




}