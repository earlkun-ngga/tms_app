import 'dart:convert';
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
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/models/Car_model.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/screens/login/scanChangeCar/successScanChangeCar.dart';
import 'package:tms_app_mobile/screens/login/scanChangeTrailer/successScanChangeTrailer.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;




class ScanChangeTrailer extends StatefulWidget
{
  late String idCar;
  late String idDriver;
  late String userId;
  @override
  _ScanChangeTrailerState createState() => _ScanChangeTrailerState();
  ScanChangeTrailer(this.idDriver, this.userId, this.idCar);
}



class _ScanChangeTrailerState extends State<ScanChangeTrailer>
{
  late String barcodeResult = "";
  bool kebenaran = false;

  //TANGGAL DAN WAKTU
 
  late String selectedDate;
  late String selectedTime;
  late String namaLokasiField = 'Di Luar Area';
  late String idLocation = '99';
  CarModel car = CarModel();
  SessionUser sesusr = SessionUser();
  GeolocationModel geolomod = GeolocationModel();


  @override 
  void initState() {
    super.initState();
    print(widget.idDriver);
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
      
      Position posisi = await Geolocator.getCurrentPosition();
      print('Posisi Anda : ${posisi.latitude}, ${posisi.longitude}');
      var semuadatalokasi = await geolomod.getDataLocationAll();
      print(semuadatalokasi);
      String namalokasibener;
      for(var semudatlok in semuadatalokasi['data'])
      { 
        print('Jarak di : ${semudatlok['name']}');
        var jarak =  Geolocator.distanceBetween(posisi.latitude, posisi.longitude, double.parse(semudatlok['latitude']), double.parse(semudatlok['longitude']));
        print('Jarak : ${jarak} M');
        print('Id Loct : ${semudatlok['id'].toString()}');
        if(jarak < 2000)
        {
          setState(() {
            this.namaLokasiField = semudatlok['name'];
            this.idLocation = semudatlok['id'].toString();
          });
        }
      }



      setState(() {
        this.kebenaran = true;
        DateTime now = DateTime.now();
        String strDate = now.toString();
        selectedDate = strDate.substring(0,10);
        selectedTime = strDate.substring(10,19);
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
  @override 
  Widget build(BuildContext context)
  {
  return Scaffold(
      backgroundColor: quiz_app_background,
       appBar: AppBar(
        title: Text(
          'Ganti Trailer',
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
                                  builder: (BuildContext context) =>Dashboard(),
                                ),
                                (route) => false,);
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
              Text('Untuk Mengganti Trailer pada Mobil, silahkan Scan QR Code Trailer',
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
        FutureBuilder(
                future: car.getInfoTrailerByQrCode(this.barcodeResult.toString().substring(4)),
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(snapshot.hasData) {
                  // print('status car = ${snapshot.data}');
                  return SizedBox(
                  height: 350,
                  child: Column(
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
                   Text('Trailer Information', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: textSizeXLarge, fontWeight: FontWeight.bold
                  ),),
                  Divider(),
                  Row(children: [
                    Text('Uji No :', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                  ),),
                  Text(' ${snapshot.data['data']['uji_no']}', style: TextStyle(
                    color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold
                  ),),
                  ],),
                  SizedBox(height: 10.0),
                  Row(children: [
                    Text('Trailer No :', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                  ),),
                  Text(' ${snapshot.data['data']['trailer_no'] ?? '(Tidak ada Trailer)'}', style: TextStyle(
                    color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold
                  ),),
                  ],),
                 
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                     Text('Waktu Ubah :', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                    )),
                    Text(' ${this.selectedDate} ${this.selectedTime}', style: TextStyle(
                    color: Colors.blue, fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),),
                  ],)
                 ,
                  SizedBox(height: 10.0),
             
                  
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
                        textContent: 'CHANGE CAR',
                        onPressed: () async {

                print('val : ${this.barcodeResult.toString().substring(4)}');
                buatLoadingLogin(context);
                Position posisi = await Geolocator.getCurrentPosition();
                final response = await http.post(Uri.parse('${apiconf.urlApi}api/car/update'),
                body: 
                {
                      "car[id]" : "${widget.idCar}",
                     "car[chasis_id]" : "${snapshot.data['data']['id']}"
                  }
                );
              final dataCar = json.decode(response.body);
              if(response.statusCode == 200)
              {
                
              

                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil<dynamic>(
                context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => SuccessChangeTrailer()
                  ),
                  (route) => false,
                );
              } else if(response.statusCode == 422) {
                print(json.decode(response.body));
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (BuildContext context) => new AlertDialog(
                    title: new Text('Gagal !!!'),
                    content: new Text('Anda Sudah Absen dan /  Menggunakan Mobil Ini !'),
                    actions: <Widget>[
                        new IconButton(
                            icon: new Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ));
                      setState(() {
                        this.kebenaran = false;
                      });
              } else {
                print(json.decode(response.body));
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
          title: new Text('Gagal !!!'),
          content: new Text('Anda Anda Gagal Absen, Karena Barcode tidak valid :('),
          actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ));
            setState(() {
              this.kebenaran = false;
            });
              }
              print(response.statusCode);
              print(this.selectedDate);
              print(this.selectedTime);
          })),
              ),
              VerticalDivider(),
              Expanded(
              child: 
              Container(
                    
                    child: qb1(
                        textContent: 'WRONG CAR',
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
                  ).paddingOnly(top: MediaQuery.of(context).size.height / 5);
                  } else {
                    return Center(child: CircularProgressIndicator(

                      backgroundColor: Colors.lightGreen,
                    color: Colors.lightBlue,
                    ));
                  }
                })


        : Container(),

      ],),
      
     


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
