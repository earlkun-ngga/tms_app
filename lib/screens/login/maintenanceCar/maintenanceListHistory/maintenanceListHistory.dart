import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Service_model.dart';
import 'package:tms_app_mobile/screens/login/maintenanceCar/maintenanceListHistory/detailMaintenance.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
//import 'QuizDetails.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';
class MaintenanceListHistory extends StatefulWidget {

  String idDriver;
  MaintenanceListHistory(this.idDriver);

  @override
  _MaintenanceListHistoryState createState() => _MaintenanceListHistoryState();
}

class _MaintenanceListHistoryState extends State<MaintenanceListHistory> {


  // TripModel tripmod = TripModel();
  Service_model servmod = Service_model();
  int selectedPos = 1;

  @override
  void initState() {
  selectedPos = 1;
    print('History Maintenance for ID : ${widget.idDriver}');
    servmod.getListServiceHistory('${widget.idDriver}').then((value) => {
      print(value),
      print(value['total_count'])

    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    


    return RefreshIndicator(child: SafeArea(
      child: Scaffold(
         appBar: AppBar(
        title: Text(
          'My Maintenance List History',
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
        body: Column(children: [
      
          Expanded(
            flex: 9,
            child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: 
            FutureBuilder(
              future: servmod.getListServiceHistory('${widget.idDriver}'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                
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

                      Expanded(
                      flex: 1,  
                      child: 
                      Container(
                        
                  child:  Container(
                  width: width,
                  decoration: boxDecoration(
                    radius: spacing_middle, bgColor: quiz_white, showShadow: false),
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
                              'SERVICE / BAN',
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
                      
                    ],
                  ),
                ),
                      )
                      ),

                    (this.selectedPos == 1) ? 
                     Expanded(
                       flex: 9, 
                       child: 
                       ListView.builder(
                        // itemCount: snapshot.data['total_count'],
                        itemCount: snapshot.data['total_count'],
                        itemBuilder: (BuildContext context, int index){
                          return (snapshot.data['data'][index]['service_type'] == '01' ||
                          snapshot.data['data'][index]['service_type'] == '02'
                           ) ? ListTileMaintenanceHistory('${snapshot.data['data'][index]['id']}',
                          '${snapshot.data['data'][index]['start_date']}',
                          '${snapshot.data['data'][index]['status']}',
                          '${snapshot.data['data'][index]['car_id']}',
                          '${snapshot.data['data'][index]['manufacture_type']}',
                          ) : Container();
                    }
                    ),
                     ) : Expanded(
                       flex: 9, 
                       child: 
                       ListView.builder(
                        itemCount: snapshot.data['total_count'],
                        itemBuilder: (BuildContext context, int index){
                          return (snapshot.data['data'][index]['service_type'] == '03') ? ListTileMaintenanceHistory('${snapshot.data['data'][index]['id']}',
                          '${snapshot.data['data'][index]['start_date']}',
                          '${snapshot.data['data'][index]['status']}',
                          '${snapshot.data['data'][index]['car_id']}',
                          '${snapshot.data['data'][index]['manufacture_type']}',
                          ) : Container();
                    }
                    ),
                     ) 
                    ],
                  );

                }
              },
            )
        )
        
        
        ,)

        ],)
      ),
    ), 
    
    
    onRefresh: () async {
      Navigator.pop(context);
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MaintenanceListHistory(widget.idDriver)),
      ); 

    });
  }
}


class ListTileMaintenanceHistory extends StatelessWidget {

  String idMaintenance;
  String tanggalBuatMaintenance;
  String idStatusMaintenance;
  ListTileMaintenanceHistory(this.idMaintenance, this.tanggalBuatMaintenance, this.idStatusMaintenance, this.idCar, this.maintenanceType);
  String idCar;
  String maintenanceType;

  @override 
  Widget build(BuildContext context) {


                  return Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                      children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                          color: quiz_white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               
                              Expanded(

                                flex: 3,
                                child: Column(
                                 children: [
                                   Chip(
                                    label: (this.idStatusMaintenance == '01') ? Text('REQUEST', style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                    ),) : (this.idStatusMaintenance == '02') ? Text('PROCESS', style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                    ),) : Text('DONE', style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                    ),),
                                    backgroundColor: 
                                    (this.idStatusMaintenance == '01') ? 
                                    Colors.purpleAccent : 
                                    
                                    (this.idStatusMaintenance == '02') ? 
                                    Colors.blueAccent : 
                                    Colors.greenAccent
                                    ),
                                    Chip(
                                    label: (this.maintenanceType == '01') ? Text('CAR', style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                    ),) : Text('TRAILER', style: TextStyle(
                                              color: Colors.white, 
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold
                                              ),) ,
                                              backgroundColor: (this.maintenanceType == '01') ? Colors.orangeAccent : Colors.blueAccent
                                            ),
                                 ],
                               ),
                              ),
                                
                              Expanded(
                              flex: 6,
                              child:             
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text('ID : #${this.idMaintenance}', fontSize: textSizeLargeMedium, maxLine: 2, fontFamily: fontMedium).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                                  text('${this.tanggalBuatMaintenance}', textColor: quiz_textColorSecondary).paddingOnly(left: 16, right: 16, bottom: 8),
                               

                                    
                                ],
                              ),),

                              Expanded(
                              flex: 1,
                              child: 
                              
                              Container(
                                child: Icon(Icons.arrow_forward_rounded)
                              )
                              ),

                            ],)
                          ],
                        ),
                      ),
                    ],
                  ),
                ).cornerRadiusWithClipRRect(16).onTap(() {
                  
                   Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailMaintenance('${this.idMaintenance}')),);
                  
                });
  }

}
