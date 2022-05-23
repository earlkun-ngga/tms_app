import 'dart:convert';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Geolocation_model.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/models/Car_model.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/screens/login/scanChangeCar/successScanChangeCar.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/mainTripActivities.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;




class CheckOut extends StatefulWidget
{
  late String idTrip;
  @override
  _CheckOutState createState() => _CheckOutState();
  CheckOut(this.idTrip);

}



class _CheckOutState extends State<CheckOut>
{
  late String barcodeResult = "";
  bool kebenaran = false;

  //TANGGAL DAN WAKTU
 
  late String selectedDate;
  late String selectedTime;
  CarModel car = CarModel();
  SessionUser sesusr = SessionUser();
  GeolocationModel geomod = GeolocationModel();
  TripModel tripmod = TripModel();


  

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Di CheckOutScan (ID) : ${widget.idTrip}');
  }
  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Batal', true, ScanMode.QR);
      print(barcodeScanRes);
      buatLoadingLogin(context);
      var datascanvalid = await geomod.getScanValidationCheckLocation('${barcodeScanRes}');
      print('Data Scan Valid (CODE) : ${datascanvalid['code']}');
      if(datascanvalid['code'] == 200)
      {
        await tripmod.updateStatusTripStart('${widget.idTrip}');
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => MainTripActivities('${widget.idTrip}'),
        ),
        (route) => false,);

      } else {
        Navigator.pop(context);
         showDialog(
                 context: context,
                 builder: (BuildContext context) => new AlertDialog(
                 title: new Text('trip.scan_checkout.failed'.tr()),
                 content: new Text('trip.scan_checkout.failed_detail'.tr()),
                 actions: <Widget>[
                 new IconButton(
                 icon: new Icon(Icons.close),
                 onPressed: () {
                 Navigator.pop(context);
                 })
                 ],
                 ));
       
      }
      
      
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      barcodeResult = barcodeScanRes;
    });
  }

  
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      barcodeResult = barcodeScanRes;
    });
  }
  @override 
  Widget build(BuildContext context)
  {
  return Scaffold(
      backgroundColor: quiz_app_background,
       appBar: AppBar(
        title: Text(
          'Scan Check Out',
          style: primaryTextStyle(size: 18, fontFamily: "Medium"),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: quiz_colorPrimary,
          size: 30,
        ).onTap(() {
          Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => MainTripActivities('${widget.idTrip}'),
                                ),
                                (route) => false,);
        }),
        centerTitle: true,
        backgroundColor: quiz_app_background,
        elevation: 0.0,
      ),   body: Stack(children: [
        Container(
      color: quiz_app_background, 
      child: Container(
      color: quiz_app_background,
      child: Column(
      children: <Widget>[
           Container(
            margin: const EdgeInsets.only(left:30, right: 30, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('trip.scan_checkout.title'.tr(),
              style: TextStyle(
                color: quiz_textColorPrimary,
                fontSize: 15.0
              ),
              )
            ],
          ) ,),
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 2,
                margin: const EdgeInsets.only(left:20, right: 20, top: 30),
                decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: quiz_white, width: 4)),
                child:  Image.asset('assets/gif/scan_fif.gif',
                             height: MediaQuery.of(context).size.width * 0.3, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                            )
              ),
          
            ],
          ),
          SizedBox(height: 30.0,),
            Container(
                    margin: EdgeInsets.all(24.0),
                    child: quizButton(
                        textContent: 'SCAN BARCODE',
                        onPressed: () {
                          scanQR();
                        })),
                      ],
                    ),
                  )
          ) 
      ]),
              );
             
     


   
  }


  buatLoadingLogin(BuildContext context) {
    return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightGreen,
                    color: Colors.lightBlue,
                  ),
                );
              });
  }

}
