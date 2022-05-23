import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/historyTrip/detailHistoryTrip.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';



class HistoryTrip extends StatefulWidget {

  String idDriver;
  HistoryTrip(this.idDriver);

  @override
  _HistoryTripState createState() => _HistoryTripState();
}

class _HistoryTripState extends State<HistoryTrip> {


  TripModel tripmod = TripModel();
  int selectedPos = 1;

  @override
  void initState() {

    print('History Trip for ID : ${widget.idDriver}');
    tripmod.getHistoryTripByIdDriver('${widget.idDriver}').then((value) => {
      print(value),
      print(value['total_count'])

    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    


    return RefreshIndicator(
      
      child: 
    
    SafeArea(
      child: Scaffold(
         appBar: AppBar(
        title: Text(
          'History Trip',
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
              future: tripmod.getHistoryTripByIdDriver('${widget.idDriver}').catchError(
                  (error) {
                    showDialog(
                              context: context,
                              builder: (BuildContext context) => new AlertDialog(
                                                title: new Text('Gagal'),
                                                content: new Text('Koneksi Anda Bermasalah, tidak dapat terhubung ke Server'),
                                                actions: <Widget>[
                                                  new IconButton(
                                                      icon: new Icon(Icons.history),
                                                      onPressed: () {
                                                       Navigator.pushAndRemoveUntil<dynamic>(
                                                        context,
                                                        MaterialPageRoute<dynamic>(
                                                          builder: (BuildContext context) => HistoryTrip('${widget.idDriver}'),
                                                        ),
                                                        (route) => false,);
                                                      })
                                                ],
                                              ));
                  } 
                ),
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

                  return  Column(
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
                              'BELUM SELESAI',
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
                              'SELESAI',
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
                    itemCount: snapshot.data['total_count'],
                    itemBuilder: (BuildContext context, int index){
                      return (snapshot.data['data'][index]['status'] != '08') ? ListTileHistoryTrip('${snapshot.data['data'][index]['id']}',
                      '${snapshot.data['data'][index]['created_at']}',
                      '${snapshot.data['data'][index]['status']}') : Container();
                        }
                      ),   
                      ) :
                      Expanded(
                    flex: 9,  
                    child: 
                    ListView.builder(
                    itemCount: snapshot.data['total_count'],
                    itemBuilder: (BuildContext context, int index){
                      return (snapshot.data['data'][index]['status'] == '08') ? ListTileHistoryTrip('${snapshot.data['data'][index]['id']}',
                      '${snapshot.data['data'][index]['created_at']}',
                      '${snapshot.data['data'][index]['status']}') : Container();
                    }

                      ),   
                      ), 
                    ],
                  );

                }

              },
            )
          
        
        
        
        )
        
        
        ,)

        ],)
      ),
    )
    
    , onRefresh: () async {
      Navigator.pop(context);
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryTrip(widget.idDriver)),
      ); 
    }
    );
  }
}


class ListTileHistoryTrip extends StatelessWidget {

  String idTrip;
  String tanggalBuatTrip;
  String idStatusTrip;
  ListTileHistoryTrip(this.idTrip, this.tanggalBuatTrip, this.idStatusTrip);

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
                               (this.idStatusTrip == '08') ?
                               Chip(
                                label: Text('SELESAI', style: TextStyle(
                                color: Colors.white, 
                                fontSize: 15.0,
                                              fontWeight: FontWeight.bold
                                              ),),
                                              backgroundColor: Colors.greenAccent
                                            ) : 
                              (this.idStatusTrip == '07') ? 
                                Chip(
                                label: Text('DOCUMENT', style: TextStyle(
                                color: Colors.white, 
                                fontSize: 15.0,
                                              fontWeight: FontWeight.bold
                                              ),),
                                              backgroundColor: Colors.purpleAccent
                                            ) : 
                              (this.idStatusTrip == '04') ?
                              Chip(
                                label: Text('CANCEL', style: TextStyle(
                                color: Colors.white, 
                                fontSize: 15.0,
                                              fontWeight: FontWeight.bold
                                              ),),
                                              backgroundColor: Colors.redAccent
                                            )  : 
                                 (this.idStatusTrip == '03') ?
                              Chip(
                                label: Text('REJECT', style: TextStyle(
                                color: Colors.white, 
                                fontSize: 15.0,
                                              fontWeight: FontWeight.bold
                                              ),),
                                              backgroundColor: Colors.redAccent
                                            )  : 
                                Chip(
                                label: Text('ON TRIP', style: TextStyle(
                                color: Colors.white, 
                                fontSize: 15.0,
                                              fontWeight: FontWeight.bold
                                              ),),
                                              backgroundColor: Colors.blueAccent
                                            ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text('Trip ID : ${this.idTrip}', fontSize: textSizeLargeMedium, maxLine: 2, fontFamily: fontMedium).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                                   text('${this.tanggalBuatTrip}', textColor: quiz_textColorSecondary).paddingOnly(left: 16, right: 16, bottom: 8),  
                                ],
                              )
                            ],)
                          ],
                        ),
                      ),
                    ],
                  ),
                ).cornerRadiusWithClipRRect(16).onTap(() {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailHistoryTrip('${this.idTrip}')),);
                });
  }

}
