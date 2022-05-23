import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Car_model.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';

//RES LOCAL
import 'package:tms_app_mobile/screens/login/maintenanceCar/step2FormInputServiceCar.dart';
import 'package:tms_app_mobile/screens/login/maintenanceCar/step2FormInputServiceTriller.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/popUpGetJob.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';


class ScanMaintenance extends StatefulWidget {
  late String idDriver;
  late String userId;
  @override 
  _ScanMaintenance createState() => _ScanMaintenance();
  ScanMaintenance(this.idDriver, this.userId);

}


class _ScanMaintenance extends State<ScanMaintenance>
{
  
  late String barcodeResult = "";
  late String prefixBarcode = "";
  late String jumlahTire;

  bool kebenaran = false;

  //TANGGAL DAN WAKTU
 
  late String selectedDate;
  late String selectedTime;
  CarModel car = CarModel();
  SessionUser sesusr = SessionUser();


  @override 
  void initState() {
    super.initState();
    print('step1ScanMaintenance.dart : ID Driver -> ${widget.idDriver}');
  }


  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Batal', true, ScanMode.QR);
      print(barcodeScanRes);
      setState(() {
        this.prefixBarcode = barcodeScanRes.toString().substring(0,3);
        this.kebenaran = true;
        DateTime now = DateTime.now();
        String strDate = now.toString();
        selectedDate = strDate.substring(0,10);
        selectedTime = strDate.substring(10,19);
        print(barcodeScanRes.length);
        print(barcodeScanRes.toString().substring(4));
        print(prefixBarcode);
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quiz_app_background,
       appBar: AppBar(
        title: Text(
          'Scan for Maintenance',
          style: primaryTextStyle(size: 18, fontFamily: "Medium"),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: quiz_colorPrimary,
          size: 30,
        ).onTap(() {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        backgroundColor: quiz_app_background,
        elevation: 0.0,
      ),   body: Stack(children: [
       (this.kebenaran == false) ?  Container(
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
              Text('Silahkan Pilih mobil / truck / triller untuk di Service',
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
          ) : Container(),
        (this.kebenaran == true) ? 
        (this.prefixBarcode == '001') ? FutureBuilder(
                future: car.getInfoCarByQrCode(this.barcodeResult.toString().substring(4)),
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(snapshot.hasData) {
                  // print('step1ScanMaintenance.dart : Data Car -> ${snapshot.data['data']}');
                  return SizedBox(
                  height: 350,
                  child: (snapshot.data['code'] == 422) ? 
                  
                  Column(
                    children: [

                      Container(
                    margin: const EdgeInsets.only(left:20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                         Container(),
                        ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Text('Mobil / Trailer tidak dapat di pakai', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0, fontWeight: FontWeight.bold
                  ),),
                  Divider(),
                  Row(
                    children: [
                     Text('Status :   ', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                    )),
                
                      Chip(
                        label: Text('Tidak Aktif', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.redAccent,
                      ),
                       
                  ],)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
          SizedBox(height: 15.0),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child:   Row(
            children: [
              
              Expanded(
              child: 
              Container(
                    
                    child: qb1(
                        textContent: 'GANTI MOBIL / TRAILER',
                        onPressed: () {
                         setState(() {
                           this.kebenaran = false;
                         });
                                  })),
                        ),

                      ],
                    )
                    ),
                    ],
                  )
                  :
                   Column(
                    children: [
                    Container(
                    margin: const EdgeInsets.only(left:20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecoration(radius: 16, showShadow: false, bgColor: quiz_white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                         Container(),
                        ],
                      ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  text('Maintenance', fontFamily: fontBold, fontSize: textSizeXLarge),
                  Divider(color: Colors.red,),
                  Text('Plate No Car : ${snapshot.data['data']['plate_no']}', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                  ),),
                  SizedBox(height: 10.0),
                  SizedBox(height: 10.0),
                  Chip(label: Text('CAR', style: TextStyle(
                    color: Colors.white, 
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                    ),),
                    backgroundColor: Colors.orange,
                  )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
          SizedBox(height: 15.0),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child:   Row(
            children: [
              Expanded(
              child: 
              Container(
                    child: qb2(
                        textContent: 'PILIH',
                        onPressed: () async {


                          buatLoadingLogin(context);
                          CarModel carmod = CarModel();
                         try {
                            await carmod.getInfoCarById('${snapshot.data['data']['id']}').then((value) => {
                             this.jumlahTire = value['data']['car_model']['car_spec']['tire'].toString(),
                          });
                         Navigator.pop(context);
                         Navigator.pop(context);
                          Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => FormInputMaintenance('${snapshot.data['data']['plate_no']}',
                                '${widget.idDriver}', 
                                '${snapshot.data['data']['id']}', 
                                '${widget.userId}',
                                '${this.jumlahTire}'
                                )),
                                );
                         } catch (e) {
                           print('error nya : ${e}');
                            Navigator.pop(context);
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Mobil / Trailer Tidak dapat di Maintenance'),
                                  content: new Text('Data Tire Tidak Lengkap ! \nSilahkan Periksa Data Tire / Ban Mobil di Car Model, TMS Web Management !'
                                  ),
                                  actions: <Widget>[
                                    new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ));
                         }

                               
                    })),
              ),
                VerticalDivider(),
                Expanded(
                child: 
                Container(
                      child: qb1(
                        textContent: 'WRONG ',
                        onPressed: () {
                         setState(() {
                           this.kebenaran = false;
                         });
                        })),
              ),],)),],
                  )
                  ).paddingOnly(top: MediaQuery.of(context).size.height / 5);
                  }
                  else {
                    return Center(child: 
                    CircularProgressIndicator(
                      backgroundColor: Color(0xFFACB5FD),
                      color: Color(0xFFf3f5f9),
                  ),);
                  }
                })  : FutureBuilder(
                future: car.getInfoTrailerByQrCode(this.barcodeResult.toString().substring(4)),
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(snapshot.hasData) {
                  print('Status Code : ${snapshot.data['code']}');
                  return SizedBox(
                  height: 350,
                  child: (snapshot.data['code'] == 422) ? 
                  Column(
                  children: [
                  Container(
                    margin: const EdgeInsets.only(left:20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                         Container(),
                        ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Text('Mobil / Trailer tidak dapat di pakai', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0, fontWeight: FontWeight.bold
                  ),),
                  Divider(),
                  Row(
                    children: [
                     Text('Status :   ', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                    )),
                
                      Chip(
                        label: Text('Tidak Aktif', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.redAccent,
                      ),
                       
                  ],)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
          SizedBox(height: 15.0),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child:   Row(
            children: [
              
              Expanded(
              child: 
              Container(
                    
                    child: qb1(
                        textContent: 'GANTI MOBIL / TRAILER',
                        onPressed: () {
                         setState(() {
                           this.kebenaran = false;
                         });
                        })),
              ),

            ],
          )
          ),
         
                  


                    ],
                  )
                  :
                  Column(
                    children: [
                    Container(
                    margin: const EdgeInsets.only(left:20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecoration(radius: 16, showShadow: false, bgColor: quiz_white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                         Container(),
                        ],
                      ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  text('Maintenance', fontFamily: fontBold, fontSize: textSizeXLarge),
                  Divider(color: Colors.red,),
                  Text('Uji No : ${snapshot.data['data']['uji_no']} ', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                  ),),
                  SizedBox(height: 10.0),
                  SizedBox(height: 10.0),
                  Chip(label: Text('TRAILER', style: TextStyle(
                    color: Colors.white, 
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                    ),),
                    backgroundColor: Colors.blueAccent,
                  )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
          SizedBox(height: 15.0),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child:   Row(
            children: [
              Expanded(
              child: 
              Container(
                    child: qb2(
                        textContent: 'PILIH',
                        onPressed: () async {
                        buatLoadingLogin(context);
                        CarModel carmod = CarModel();
                        try {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                          MaterialPageRoute(builder: (context) => 
                          FormInputMaintenanceTrailler(
                                '${snapshot.data['data']['uji_no']}',
                                '${widget.idDriver}', 
                                '${snapshot.data['data']['id']}', 
                                '${widget.userId}',
                                '${snapshot.data['data']['chasis_model']['chasis_spec']['tire'].toString()}'
                                )),
                                );
                         } catch (e) {
                           print('error nya : ${e}');
                            Navigator.pop(context);
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Mobil / Trailer Tidak dapat di Maintenance'),
                                  content: new Text('Data Tire Tidak Lengkap ! \nSilahkan Periksa Data Tire / Ban Mobil di Car Model, TMS Web Management !'
                                  ),
                                  actions: <Widget>[
                                    new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ));
                    }}),
              )),
                VerticalDivider(),
                Expanded(
                child: 
                Container(
                      child: qb1(
                        textContent: 'WRONG ',
                        onPressed: () {
                         setState(() {
                           this.kebenaran = false;
                         });
                        })),
              ),],)),],
                  )
                  ).paddingOnly(top: MediaQuery.of(context).size.height / 5);
                  }
                  else {
                    return Center(child: 
                    CircularProgressIndicator(
                      backgroundColor: Color(0xFFACB5FD),
                      color: Color(0xFFf3f5f9),
                  ),);
                  }
                }) 
        : Container(),],),);
          }
      }