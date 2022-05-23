import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tms_app_mobile/models/Car_model.dart';
import 'package:tms_app_mobile/models/Service_model.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/UserDriver_model.dart';
import 'package:tms_app_mobile/models/Waktu_model.dart';
import 'package:tms_app_mobile/screens/login/maintenanceCar/resultMaintenanceData.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/popUpGetJob.dart';
import 'package:tms_app_mobile/screens/template/form/lib/card_settings.dart';
import 'package:tms_app_mobile/screens/template/model/QuizModels.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizDataGenerator.dart';
//import 'QuizDetails.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';
import 'package:tms_app_mobile/screens/template/form/lib/widgets/card_settings_panel.dart';
import 'package:tms_app_mobile/screens/template/form/lib/widgets/information_fields/card_settings_header.dart';
import 'package:tms_app_mobile/screens/template/form/lib/widgets/picker_fields/card_settings_checkbox_picker.dart';
import 'package:tms_app_mobile/screens/template/form/lib/widgets/picker_fields/card_settings_date_picker.dart';
import 'package:tms_app_mobile/screens/template/form/lib/widgets/picker_fields/card_settings_list_picker.dart';
import 'package:tms_app_mobile/screens/template/form/lib/widgets/picker_fields/card_settings_time_picker.dart';
import 'package:tms_app_mobile/screens/template/form/lib/widgets/text_fields/card_settings_text.dart';




class FormInputMaintenanceTrailler extends StatefulWidget {
  String ujiNo;
  String idCar;
  String idDriver;
  String userId;
  String jumlahTire;

  @override
  _FormInputMaintenanceTrailler createState() => _FormInputMaintenanceTrailler();

  FormInputMaintenanceTrailler(this.ujiNo, this.idDriver, this.idCar, this.userId, this.jumlahTire);
}

class _FormInputMaintenanceTrailler extends State<FormInputMaintenanceTrailler> {
  late List<NewQuizModel> mListings;
  int selectedPos = 1;
  String idMaintenance = '';

  //VALUE FORM-SERVICE-CAR
 

  //INSTANCE CLASS
  UserDriver userdrivmod = UserDriver(); 
  Service_model servmod = Service_model();


  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mListings = getQuizData();
    
    print('step2FormInputServiceCar.dart : ID Driver -> ${widget.idDriver}');
    print('step2FormInputServiceCar.dart : ID Triller -> ${widget.idCar}');
    print('step2FormInputServiceCar.dart : Jumlah Tire -> ${widget.jumlahTire}');
    print(widget.ujiNo);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final quizAll = StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      scrollDirection: Axis.vertical,
      itemCount: mListings.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        changeStatusColor(quiz_app_background);
        return Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                  imageUrl: mListings[index].quizImage,
                  height: width * 0.4,
                  width: MediaQuery.of(context).size.width / 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                  color: quiz_white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    text(mListings[index].quizName, fontSize: textSizeMedium, maxLine: 2, fontFamily: fontMedium).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                    text(mListings[index].totalQuiz, textColor: quiz_textColorSecondary).paddingOnly(left: 16, right: 16, bottom: 8),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
         // QuizDetails().launch(context);
        });
      },
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.67, mainAxisSpacing: 16, crossAxisSpacing: 16),
    );

    Widget quizCompleted = StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      scrollDirection: Axis.vertical,
      itemCount: mListings.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        changeStatusColor(quiz_app_background);
        return Container(
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                  imageUrl: mListings[index].quizImage,
                  height: width * 0.4,
                  width: MediaQuery.of(context).size.width / 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                  color: quiz_white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(mListings[index].quizName, fontSize: textSizeMedium, maxLine: 2, fontFamily: fontMedium).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                    text(mListings[index].totalQuiz, textColor: quiz_textColorSecondary).paddingOnly(left: 16, right: 16, bottom: 16),
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: textSecondaryColor.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(quiz_green),
                    ).paddingOnly(left: 16, right: 16, bottom: 16),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
         // QuizDetails().launch(context);
        });
      },
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.60, mainAxisSpacing: 16, crossAxisSpacing: 16),
    );

    return SafeArea(
      child: Scaffold(
       
         appBar: AppBar(
        title: Text(
          'Form Services',
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
      ),
        backgroundColor: quiz_app_background,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[

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
                  
                  Chip(label: Text('TRAILLER', style: TextStyle(
                    color: Colors.white, 
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                    ),),
                    backgroundColor: Colors.blueAccent,
                  ),
                  Text('Uji No : ${widget.ujiNo} ', style: TextStyle(
                    color: quiz_textColorSecondary, fontSize: 20.0
                  ),),
                  SizedBox(height: 10.0),
                  

                  FutureBuilder(
                    future: userdrivmod.getDataDriveById('${widget.idDriver}'),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {

                      if(snapshot.data == null)
                      {
                        return SkeletonLine(
                            style: SkeletonLineStyle(
                            height: 16,
                            width: 220.0,
                            borderRadius: BorderRadius.circular(4)),
                                              );
                      } else {

                        return Text('Driver : ${snapshot.data['data']['name']} ', style: TextStyle(
                     color: quiz_textColorSecondary, fontSize: 20.0
                   ),);

                      }


                  }),
                  SizedBox(height: 10.0),
               
                  FutureBuilder(
                    future: servmod.getIdMaintenance(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {

                      if(snapshot.data == null)
                      {
                        return SkeletonLine(
                            style: SkeletonLineStyle(
                            height: 16,
                            width: 220.0,
                            borderRadius: BorderRadius.circular(4)),
                                              );
                      } else {
                        
                        return    Text('ID Maintenance : ${snapshot.data['data']} ', style: TextStyle(
                     color: quiz_textColorSecondary, fontSize: 20.0
                   ),);

                      }


                  })


                 
                  
                  
                  ],
                ),
              ],
            ),
          ),

          

        ],
      ),
    ),


           
                SizedBox(height: 20.0,),
                Container(
                  width: width,
                  decoration: boxDecoration(radius: spacing_middle, bgColor: quiz_white, showShadow: false),
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            selectedPos = 1;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(spacing_middle), bottomLeft: Radius.circular(spacing_middle)),
                              color: selectedPos == 1 ? quiz_white : Colors.transparent,
                              border: Border.all(color: selectedPos == 1 ? quiz_white : Colors.transparent),
                            ),
                            child: text(
                              'SERVIS TRAILER',
                              fontSize: textSizeMedium,
                              isCentered: true,
                              fontFamily: fontMedium,
                              textColor: selectedPos == 1 ? quiz_textColorPrimary : quiz_textColorSecondary,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(height: 40, width: 1, color: quiz_light_gray).center(),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPos = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), bottomRight: Radius.circular(spacing_middle)),
                              color: selectedPos == 2 ? quiz_white : Colors.transparent,
                              border: Border.all(color: selectedPos == 2 ? quiz_white : Colors.transparent),
                            ),
                            child: text(
                              'ISI ANGIN',
                              fontSize: textSizeMedium,
                              isCentered: true,
                              fontFamily: fontMedium,
                              textColor: selectedPos == 2 ? quiz_textColorPrimary : quiz_textColorSecondary,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(height: 40, width: 1, color: quiz_light_gray).center(),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPos = 3;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), bottomRight: Radius.circular(spacing_middle)),
                              color: selectedPos == 3 ? quiz_white : Colors.transparent,
                              border: Border.all(color: selectedPos == 3 ? quiz_white : Colors.transparent),
                            ),
                            child: text(
                              'GANTI BAN',
                              fontSize: textSizeMedium,
                              isCentered: true,
                              fontFamily: fontMedium,
                              textColor: selectedPos == 3 ? quiz_textColorPrimary : quiz_textColorSecondary,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    child: selectedPos == 1 ? ServiceTrailerForm('${widget.idDriver}', '${widget.idCar}', '${widget.userId}') : selectedPos == 2 ? TireFormAir('${widget.jumlahTire}', '${widget.idCar}','${widget.userId}', '${widget.idDriver}') : TireFormChange('${widget.jumlahTire}', '${widget.idCar}','${widget.userId}', '${widget.idDriver}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class ServiceTrailerForm extends StatefulWidget {

  String idDriver;
  String idCar;
  String userId;


  @override 
  _ServiceTrailerFormState createState() => _ServiceTrailerFormState();
  ServiceTrailerForm(this.idDriver, this.idCar, this.userId);

}


class _ServiceTrailerFormState extends State<ServiceTrailerForm> {

  //INSTANCE DATE
  WaktuModel waktumod = WaktuModel();
  Service_model servmod2 = Service_model();
  SessionUser sesusr = SessionUser();
  UserDriver usrdrv = UserDriver();
  
  
  TextEditingController engineerText = TextEditingController();
  TextEditingController kilometerText =   TextEditingController();
  TextEditingController remarkText = TextEditingController();

  String usr = '';
  String pss = '';
  String serviceDate = '';
  String serviceTime = '';
  String serviceId = '';
  String selectedService = '';
  String estimateFinishDate = '';
  String estimateTime = '';
  String idMaintenanceSf = '';
  String idLokasiBengkel = '';
  var itemLokasiBengkel = [];
  var serviceList = [];
  var serviceListId = [];
  


  Future getServiceCode() async {
    var serviceItem = this.idMaintenanceSf;
    return serviceItem;
  }
  @override
  void initState() {
    super.initState();
    servmod2.getServiceItemTrailer().then((value) => {
    for(int i = 0; i < value.length; i++)
    {
      setState((){
        this.serviceList.add('${value['data'][i]['name']} - ${value['data'][i]['item_id']}');
      })
    }
    });
    servmod2.getIdMaintenance().then((value) => {
      setState((){
        this.idMaintenanceSf = '${value['data']}';
      }),
    });
    servmod2.getLokasiServis().then((value) => {
      for(int i = 0; i < value.length; i++)
    {
      setState((){
        this.itemLokasiBengkel.add('${value['data'][i]['name']} - ${value['data'][i]['id']}');
      })
    },
    print(value)
    });
    this.serviceDate = '${waktumod.getTanggalStripFormat()}';
    this.estimateFinishDate = '${waktumod.getTanggalStripFormat()}';
    this.serviceTime = '${waktumod.getTimeFirstFormat().substring(0,6)}';
    this.estimateTime = '${waktumod.getTimeFirstFormat().substring(0,6)}';
  }
  @override 
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      future: getServiceCode(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data == null)
        {
          return Center(
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  ),
                  SizedBox(height: 20,),
                  Text('Mohon Tunggu...', style: TextStyle(
                  color: Colors.grey
                ),),
                ],)
              ,);
        }
        else {
          return Column(
          children: [
          CardSettings(
            labelAlign: TextAlign.center, // change the label alignment
            labelWidth: 150.0, // change how wide the label portion is
            contentAlign: TextAlign.center, // alignment 
            children: [
              CardSettingsSection(
                children: [
                    CardSettingsHeader(
                    color: Color(0xFFACB5FD),
                    child: Container(
                    height: 50,
                    child: Center(
                      child: Text('FORM SERVIS', style: TextStyle(fontSize: 20)),
              ),
            ),
              ),

                CardSettingsListPicker(
                  icon: Icon(Icons.location_on),
                  label: 'LOKASI BENGKEL',
                  items: this.itemLokasiBengkel,
                  initialItem: [],
                  onChanged: (value){

                    setState(() {
                      this.idLokasiBengkel = value.toString().substring(value.toString().length - 1, value.toString().length );
                    });
                  },
                  ),
                 CardSettingsText(
                   icon: Icon(Icons.engineering),
                    label: 'ENGINEER',
                    controller: engineerText,
                    inputAction: TextInputAction.done,
                    initialValue: '',
                ),
            
                CardSettingsDatePicker(
                  label: 'TANGGAL SERVIS',
                  onChanged: (value)
                  {
                    this.serviceDate = '${value.toString().substring(0,10)}';
                  },
                ),

                CardSettingsTimePicker(
                  icon: Icon(Icons.car_repair),
                  label: 'JAM SERVIS',
                  onChanged: (value)
                  {
                     setState(() {
                      this.serviceTime = '${value.hour}:${value.minute}';
                    });
                  },
                ),

                CardSettingsDatePicker(
                  label: 'PERKIRAAN SELESAI',
                  onChanged: (value)
                  {
                    setState(() {
                      this.estimateFinishDate = '${value.toString().substring(0,10)}';
                    });
                  },
                ),
                  CardSettingsTimePicker(
                  icon: Icon(Icons.lock_clock),
                  label: 'JAM PERKIRAAN',
                  onChanged: (value)
                  {
                     setState(() {
                      this.estimateTime = '${value.hour}:${value.minute}';
                    });
                  },
                ),

                CardSettingsCheckboxPicker(
                  icon: Icon(Icons.room_service),
                  label: 'PILIH SERVIS',
                  items: serviceList,
                  
                  initialItems: [],
                  onChanged: (value) {
                    setState(() {
                      this.selectedService = '${value.toString()}';
                    });
                  },
                ),
                 CardSettingsParagraph(
                   icon: Icon(Icons.book),
                   controller: remarkText,
                   label: 'REMARK (Catatan)',
                   inputAction: TextInputAction.done,
                 ),
                 CardSettingsButton(
                   backgroundColor: Colors.orange,
                   label: 'SIMPAN',
                   textColor: Colors.white,
                   onPressed: (){
                    if(this.selectedService == '[]' || this.selectedService == ''){
                       showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Peringatan'),
                                  content: new Text('Pastikan Pilih Salah satu Servis'),
                                  actions: <Widget>[
                                    new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ));
                     } else if(this.idLokasiBengkel == '')
                     {

                       showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Peringatan'),
                                  content: new Text('Pastikan Memilih Lokasi Bengkel !'),
                                  actions: <Widget>[
                                    new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ));


                     }
                      else {
                       showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Validasi Data '),
                                  content: Text('Apakah data sudah benar ?'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end , crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: new Icon(Icons.check,
                                            color: Colors.greenAccent,
                                            ),
                                      onPressed: () async {
                                      var arrayService = [];
                                      var arrayServiceId = [];
                                      String pureString = this.selectedService.substring(1, this.selectedService.length - 1);
                                      print(pureString.split(', '));
                                      arrayService = pureString.split(', ');
                                      print(arrayService);
                                      for(var i = 0; i < arrayService.length; i++)
                                      {
                                        print('Service Name Id -> ${arrayService[i].toString().substring(arrayService[i].toString().length - 3, arrayService[i].toString().length)}');
                                        arrayServiceId.add(arrayService[i].toString().substring(arrayService[i].toString().length - 3, arrayService[i].toString().length));
                                      }
                                      print('Service Id - Dah DI ARRAY> ${arrayServiceId}');
                                      print('User Id -> ${widget.userId}');
                                      print('ID Lokasi Bengkel -> ${this.idLokasiBengkel}');
                                      buatLoadingLogin(context);
                                      final responseApi = await servmod2.setMaintenanceTrailer(
                                        "${this.idMaintenanceSf}", 
                                        "${widget.idDriver}", 
                                        "${widget.idCar}", 
                                        "${engineerText.text.toString()}", 
                                        "${this.idLokasiBengkel}",
                                        "${this.serviceDate}", 
                                        "${this.serviceTime}", 
                                        "${this.estimateFinishDate}", 
                                        "${this.estimateTime}",
                                        "${remarkText.text}", 
                                        "${widget.userId}", 
                                          arrayServiceId
                                          );

                                      print('Status Code Upload Form Maintenance -> ${responseApi.statusCode}');
                                      var resultresponse = json.decode(responseApi.body);
                                      print(' Response -> ${resultresponse}');
                                      print(' Pesan -> ${resultresponse['message']}');
                                      print('(Details) Pesan -> ${resultresponse['details']}');
                                              if(responseApi.statusCode == 200)
                                                {
                                                  Navigator.of(context).pop();
                                                  Navigator.pushAndRemoveUntil<dynamic>(
                                                  context,
                                                    MaterialPageRoute<dynamic>(
                                                      builder: (BuildContext context) => SuccessInputMaintenance('${this.idMaintenanceSf}')
                                                    ),
                                                    (route) => false,
                                                  );
                                                } else {
                                                    return  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) => new AlertDialog(
                                                      title: new Text('Gagal !!!'),
                                                      content: new Text('Gagal Mengirim Form!'),
                                                      actions: <Widget>[
                                                          new IconButton(
                                                              icon: new Icon(Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                              })
                                                        ],
                                                      ));
                                                }
                                      }),
                                        IconButton(
                                            icon: new Icon(Icons.close,
                                            color: Colors.redAccent
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    )
                                  ],
                                ));

                
                    
                  }

                     

                 })
              
        ],)
      ],
    ),

    SizedBox(height: 70.0),
    


    ],);
        }



    });
  }

    buatLoadingLogin(BuildContext context) {
    return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  ),
                );
              });
  }


}


class TireFormAir extends StatefulWidget {

  late String jumlahTire;
  late String idCar;
  late String userId;
  late String idDriver;
  @override
  _TireFormAirState createState() => _TireFormAirState(jumlahTire);
  TireFormAir(this.jumlahTire, this.idCar, this.userId, this.idDriver);

}


class _TireFormAirState extends State<TireFormAir> {

  CarModel carmod = CarModel();
  late String jumlahTire;
  _TireFormAirState(this.jumlahTire);
  WaktuModel waktumod = WaktuModel();
  Service_model servmod2 = Service_model();

   
  TextEditingController engineerText = TextEditingController();
  TextEditingController remarkText = TextEditingController();
  TextEditingController kilometerText = TextEditingController();

  String serviceDate = '';
  String serviceTime = '';
  String serviceId = '';
  String selectedService = '';
  String estimateFinishDate = '';
  String estimateTime = '';
  String idMaintenanceSf = '';

  var dataTire;
  var tanggalTire;
  var statusChange;

  var sendDataTire = [];
  int flag = 0;
  


  @override
  initState(){
    print('jumlah tire nya : ${this.jumlahTire}');
    carmod.getInfoTireTrailer('${widget.idCar}').then((value) => {
      print('Data Tire : ${value}'),
      this.dataTire = value['data']['tire'],
      this.tanggalTire = value['data']['last_check_air'],
       for(var i = 0; i < value['data']['tire'].length; i++)
          {
            setState(() {
              this.sendDataTire.add('');
            }),
          }
    });


    servmod2.getIdMaintenance().then((value) => {
      setState((){
        this.idMaintenanceSf = '${value['data']}';
      }),
    });
    this.serviceDate = '${waktumod.getTanggalStripFormat()}';
    this.estimateFinishDate = '${waktumod.getTanggalStripFormat()}';
    this.serviceTime = '${waktumod.getTimeFirstFormat().substring(0,6)}';
    this.estimateTime = '${waktumod.getTimeFirstFormat().substring(0,6)}';
  }


  @override 
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      
      future: carmod.getInfoTireTrailer('${widget.idCar}'),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if(snapshot.data == null) {
           return Center(
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  ),
                  SizedBox(height: 20,),
                  Text('Mohon Tunggu...', style: TextStyle(
                  color: Colors.grey
                ),),
                ],)
              ,);
        } else {
          return Column(
      children: [
      CardSettings(
          labelAlign: TextAlign.center, // change the label alignment
            labelWidth: 150.0, // change how wide the label portion is
            contentAlign: TextAlign.center,
      children: [
        CardSettingsSection(
          children: [
               CardSettingsHeader(
              color: Color(0xFFACB5FD),
              child: Container(
              height: 50,
              child: Center(
                 child: Text('ISI ANGIN BAN', style: TextStyle(fontSize: 20)),
              ),
            ),
              ),
                
                 CardSettingsText(
                   icon: Icon(Icons.engineering),
                    label: 'ENGINEER',
                    controller: engineerText,
                    inputAction: TextInputAction.done,
                    
                  initialValue: '',
                ),        

                CardSettingsDatePicker(
                  label: 'SERVICE DATE',
                  
                  onChanged: (value)
                  {
                    this.serviceDate = '${value.toString().substring(0,10)}';
                  },
                ),

                CardSettingsTimePicker(
                  icon: Icon(Icons.car_repair),
                  label: 'SERVICE TIME',
                  onChanged: (value)
                  {
                     setState(() {
                      this.serviceTime = '${value.hour}:${value.minute}';
                    });
                  },
                ),

                CardSettingsDatePicker(
                  label: 'PERKIRAAN SELESAI',
                  onChanged: (value)
                  {
                    setState(() {
                      this.estimateFinishDate = '${value.toString().substring(0,10)}';
                    });
                  },
                ),

                CardSettingsTimePicker(
                  icon: Icon(Icons.car_repair),
                  label: 'PERKIRAAN JAM',
                  onChanged: (value)
                  {
                     setState(() {
                      this.estimateTime = '${value.hour}:${value.minute}';
                    });
                  },
                ),

                 CardSettingsParagraph(
                   icon: Icon(Icons.book),
                   controller: remarkText,
                   label: 'REMARK (Catatan)',
                   inputAction: TextInputAction.done,
                 ),
        ],)
      ],
    ),
  SizedBox(height: 10.0,),
  for(int i = 0; i < this.dataTire.length; i++)
      CardSettings(
      children: [
        CardSettingsSection(
          children: [
             CardSettingsHeader(
              color: Colors.white,
              label: '${this.dataTire[i]['tire']} - ${
                (this.dataTire[i]['last_check_air'] == null) ? ''
                 : this.dataTire[i]['last_check_air'] 
                }',
              ),
                 CardSettingsListPicker(
                 label: 'Pressure',
                 items: [
                   '140~150',
                   '130~140',
                   '120~130',
                   '110~120',
                   '100~110',
                   '90~100',
                   '80~90', 
                   '70~80',
                   '60~70',
                   '50~60'
                   ],
                 initialItem: '${(this.dataTire[i]['tire_pressure'] == null ) ? '90~100' :  this.dataTire[i]['tire_pressure']}',
                 onChanged: (value){
                  
                  print('Panjang data : ${this.dataTire.length}');
                  print('Panjang data (Send Data Tire) : ${this.sendDataTire.length}');
                  print('Ini yang di ubah index ke : ${i}');
                  setState(() {

                  
                  var dataserv = {'label' : '${this.dataTire[i]['tire']}', 'value' : '${value}'};
                  this.sendDataTire[i] = dataserv;
                  this.dataTire[i]['last_check_air'] = '${waktumod.getTanggalStripFormat()} [UPDATE]';
                   });
                 },
                 ),
          ],
        ),
        
      ],
    ),
  
  

    SizedBox(height: 10.0,),

    CardSettings(
      children: [
        CardSettingsSection(
          children: [
            CardSettingsButton(
               backgroundColor: Colors.orange,
                   label: 'SIMPAN',
                   textColor: Colors.white,
              onPressed: (){

                 var realSendData = []; 
              for(var i = 0; i < this.sendDataTire.length; i++)
              {
                if(this.sendDataTire[i] != '')
                {
                  realSendData.add(sendDataTire[i]);
                }
              }
              print('Data Real : ${realSendData}');
              print('Panjang Data Real : ${realSendData.length}');
              print('ID Driver -> ${widget.idDriver}');
              print('ID Car -> ${widget.idCar}');
              print('ID User Id -> ${widget.userId}');
              print('ID Maintenance -> ${this.idMaintenanceSf} ');
              print('ID Maintenance -> ');
                       showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Validasi Data '),
                                  content: Text('Apakah data sudah benar ?'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end , crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: new Icon(Icons.check,
                                            color: Colors.greenAccent,
                                            ),
                                      onPressed: () async {
                                      print('User Id -> ${widget.userId}');
                                      buatLoadingLogin(context);
                                      final responseApi = await servmod2.setMaintenanceTireTrailerAir(
                                        "${this.idMaintenanceSf}", 
                                        "${widget.idDriver}", 
                                        "${widget.idCar}", 
                                        "${engineerText.text.toString()}", 
                                        "${this.serviceDate}", 
                                        "${this.serviceTime}", 
                                        "${this.estimateFinishDate}",
                                        "${this.estimateTime}" ,
                                        "${remarkText.text}", 
                                        "${widget.userId}", 
                                        realSendData);
                                      print('Status Code Upload Form Maintenance -> ${responseApi.statusCode}');
                                      var resultresponse = json.decode(responseApi.body);
                                      print(' Pesan -> ${resultresponse['message']}');
                                      print('(Details) Pesan -> ${resultresponse['details']}');
                                              if(responseApi.statusCode == 200)
                                                {
                                                  Navigator.of(context).pop();
                                                  Navigator.pushAndRemoveUntil<dynamic>(
                                                  context,
                                                    MaterialPageRoute<dynamic>(
                                                      builder: (BuildContext context) => SuccessInputMaintenance('${this.idMaintenanceSf}')
                                                    ),
                                                    (route) => false,
                                                  );
                                                } else {
                                                    return  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) => new AlertDialog(
                                                      title: new Text('Gagal !!!'),
                                                      content: new Text('Gagal Mengirim Form!'),
                                                      actions: <Widget>[
                                                          new IconButton(
                                                              icon: new Icon(Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                              })
                                                        ],
                                                      ));
                                                }
                                      }),
                                        IconButton(
                                            icon: new Icon(Icons.close,
                                            color: Colors.redAccent
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    )
                                  ],
                                ));
              
             
              })
          ],
        )
      ],
    )
    ],);
        }

      });
  }


}



class TireFormChange extends StatefulWidget {

  late String jumlahTire;
  late String idCar;
  late String userId;
  late String idDriver;
  @override
  _TireFormChangeState createState() => _TireFormChangeState(jumlahTire);
  TireFormChange(this.jumlahTire, this.idCar, this.userId, this.idDriver);

}


class _TireFormChangeState extends State<TireFormChange> {

  CarModel carmod = CarModel();
  late String jumlahTire;
  _TireFormChangeState(this.jumlahTire);
  WaktuModel waktumod = WaktuModel();
  Service_model servmod2 = Service_model();

   
  TextEditingController engineerText = TextEditingController();
  TextEditingController remarkText = TextEditingController();
  TextEditingController kilometerText = TextEditingController();

  String serviceDate = '';
  String serviceTime = '';
  String serviceId = '';
  String selectedService = '';
  String estimateFinishDate = '';
  String estimateTime = '';
  String idMaintenanceSf = '';
  String idLokasiBengkel = '';
  var itemLokasiBengkel = [];

  var dataTire;
  var tanggalTireChange;
  var statusChange;

  var sendDataTire = [];
  int flag = 0;
  


  @override
  initState(){
    print('jumlah tire nya : ${this.jumlahTire}');

     carmod.getInfoTireTrailer('${widget.idCar}').then((value) => {
      this.dataTire = value['data']['tire'],
      this.tanggalTireChange = value['data']['last_change'],
       for(var i = 0; i < value['data']['tire'].length; i++)
          {
            setState(() {
              this.sendDataTire.add('');
            }),
          }
    });
    servmod2.getIdMaintenance().then((value) => {
      setState((){
        this.idMaintenanceSf = '${value['data']}';
      }),
    });

   servmod2.getLokasiServis().then((value) => {
      for(int i = 0; i < value.length; i++)
    {
      setState((){
        this.itemLokasiBengkel.add('${value['data'][i]['name']} - ${value['data'][i]['id']}');
      })
    },
    print(value)
    });

    this.serviceDate = '${waktumod.getTanggalStripFormat()}';
    this.estimateFinishDate = '${waktumod.getTanggalStripFormat()}';
    this.serviceTime = '${waktumod.getTimeFirstFormat().substring(0,6)}';
    this.estimateTime = '${waktumod.getTimeFirstFormat().substring(0,6)}';
  }


  @override 
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      
      future: carmod.getInfoTireTrailer('${widget.idCar}'),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if(snapshot.data == null) {
           return Center(
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  ),
                  SizedBox(height: 20,),
                  Text('Mohon Tunggu...', style: TextStyle(
                  color: Colors.grey
                ),),
                ],)
              ,);
        } else {
          return Column(
      children: [
      CardSettings(
        labelAlign: TextAlign.center, // change the label alignment
            labelWidth: 150.0, // change how wide the label portion is
            contentAlign: TextAlign.center,
      children: [
        CardSettingsSection(
          children: [
               CardSettingsHeader(
              color: Color(0xFFACB5FD),
              child: Container(
              height: 50,
              child: Center(
                 child: Text('GANTI KONDISI BAN', style: TextStyle(fontSize: 20)),
              ),
            ),
              ),
               CardSettingsListPicker(
                  icon: Icon(Icons.location_on),
                  label: 'LOKASI BENGKEL',
                  items: this.itemLokasiBengkel,
                  initialItem: [],
                  onChanged: (value){

                    setState(() {
                      this.idLokasiBengkel = value.toString().substring(value.toString().length - 1, value.toString().length );
                    });
                  },
                  ),
                
                 CardSettingsText(
                   icon: Icon(Icons.engineering),
                    label: 'ENGINEER',
                    controller: engineerText,
                    inputAction: TextInputAction.done,
                    
                  initialValue: '',
                ),
                

                CardSettingsDatePicker(
                  label: 'SERVICE DATE',
                  
                  onChanged: (value)
                  {
                    this.serviceDate = '${value.toString().substring(0,10)}';
                  },
                ),

                CardSettingsTimePicker(
                  icon: Icon(Icons.lock_clock),
                  label: 'SERVICE TIME',
                  onChanged: (value)
                  {
                     setState(() {
                      this.serviceTime = '${value.hour}:${value.minute}';
                    });
                  },
                ),

                CardSettingsDatePicker(
                  label: 'PERKIRAAN SELESAI',
                  onChanged: (value)
                  {
                    setState(() {
                      this.estimateFinishDate = '${value.toString().substring(0,10)}';
                    });
                  },
                ),

                CardSettingsTimePicker(
                  icon: Icon(Icons.lock_clock),
                  label: 'PERKIRAAN JAM',
                  onChanged: (value)
                  {
                     setState(() {
                      this.estimateTime = '${value.hour}:${value.minute}';
                    });
                  },
                ),


                 CardSettingsParagraph(
                   icon: Icon(Icons.book),
                   controller: remarkText,
                   label: 'REMARK (Catatan)',
                   inputAction: TextInputAction.done,
                 ),
        ],)
      ],
    ),
  SizedBox(height: 10.0,),
  for(int i = 0; i < this.dataTire.length; i++)
      CardSettings(
      children: [
        CardSettingsSection(
          children: [
             CardSettingsHeader(
              color: Colors.white,
              label: '${this.dataTire[i]['tire']} - ${
                (this.dataTire[i]['last_change'] == null) ? ''
                 : this.dataTire[i]['last_change'] 
                }',
              ),
                 CardSettingsListPicker(
                 label: 'Condition',
                 items: [
                   '3. Tambal Ban',
                   '2. Bekas',
                   '1. Baru'
                   ],
                 initialItem: '${(this.dataTire[i]['condition'].toString() == '1') ? '1. Baru' : (this.dataTire[i]['condition'].toString() == '2') ? '2. Bekas' : ''}',
                 onChanged: (value){
                  setState(() {
                  var dataserv = {'label' : '${this.dataTire[i]['tire']}', 'value' : '${value}'};
                  this.sendDataTire[i] = dataserv;
                  this.dataTire[i]['last_change'] = '${waktumod.getTanggalStripFormat()} [UPDATE]';
                   });
                 },
                 ),
          ],
        ),
        
      ],
    ),
  
  

    SizedBox(height: 10.0,),

    CardSettings(
      children: [
        CardSettingsSection(
          children: [
            CardSettingsButton(
               backgroundColor: Colors.orange,
                   label: 'SIMPAN',
                   textColor: Colors.white,
              onPressed: (){

              if(this.idLokasiBengkel == '')
              {
                 showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Peringatan'),
                                  content: new Text('Pastikan Memilih Lokasi Bengkel !'),
                                  actions: <Widget>[
                                    new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ));
              } else {
                var realSendData = []; 
              for(var i = 0; i < this.sendDataTire.length; i++)
              {
                if(this.sendDataTire[i] != '')
                {
                  realSendData.add(sendDataTire[i]);
                }
              }
              print('Data Real : ${realSendData}');
              print('Panjang Data Real : ${realSendData.length}');
              print('ID Driver -> ${widget.idDriver}');
              print('ID Car -> ${widget.idCar}');
              print('ID User Id -> ${widget.userId}');
              print('ID Maintenance -> ${this.idMaintenanceSf} ');
              print('Substring ->  ${realSendData[0]['value'].toString().substring(0,1)}');

                  

                       showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Validasi Data '),
                                  content: Text('Apakah data sudah benar ?'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end , crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: new Icon(Icons.check,
                                            color: Colors.greenAccent,
                                            ),
                                      onPressed: () async {
                                      print('User Id -> ${widget.userId}');
                                      buatLoadingLogin(context);
                                      final responseApi = await servmod2.setMaintenanceTireTrailerChange(
                                        "${this.idMaintenanceSf}", 
                                        "${widget.idDriver}", 
                                        "${widget.idCar}", 
                                        "${engineerText.text.toString()}", 
                                        "${this.idLokasiBengkel}",
                                        "${this.serviceDate}", 
                                        "${this.serviceTime}", 
                                        "${this.estimateFinishDate}", 
                                        "${this.estimateTime}",
                                        "${remarkText.text}", 
                                        "${widget.userId}", 
                                         realSendData
                                        );
                                      print('Status Code Upload Form Maintenance -> ${responseApi.statusCode}');
                                      var resultresponse = json.decode(responseApi.body);
                                      print(' Pesan -> ${resultresponse['message']}');
                                      print('(Details) Pesan -> ${resultresponse['details']}');
                                              if(responseApi.statusCode == 200)
                                                {
                                                  Navigator.of(context).pop();
                                                  Navigator.pushAndRemoveUntil<dynamic>(
                                                  context,
                                                    MaterialPageRoute<dynamic>(
                                                      builder: (BuildContext context) => SuccessInputMaintenance('${this.idMaintenanceSf}')
                                                    ),
                                                    (route) => false,
                                                  );
                                                } else {
                                                    return  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) => new AlertDialog(
                                                      title: new Text('Gagal !!!'),
                                                      content: new Text('Gagal Mengirim Form!'),
                                                      actions: <Widget>[
                                                          new IconButton(
                                                              icon: new Icon(Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                              })
                                                        ],
                                                      ));
                                                }
                                      }),
                                        IconButton(
                                            icon: new Icon(Icons.close,
                                            color: Colors.redAccent
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    )
                                  ],
                                ));

              }
              


                   












              })
          ],
        )
      ],
    )
    
    


    ],);
        }

      });
  }


}