import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;



class Service_model {


  Future getIdMaintenance() async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/maintenance/getId'));
    var dataidmain = json.decode(response.body);

    return dataidmain;
  }


  Future getOneServiceById(String idService) async {
    var response = await http.get(Uri.parse('${apiconf.urlApi}api/maintenance/getOne/${idService}'));
    var dataservice = json.decode(response.body);
    return dataservice;

  }



  Future getServiceItem() async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/code-item/getAll'), body: {
      "code_id" : "8"
    });
    var dataserviceitem = json.decode(response.body);
    return dataserviceitem;
  }

  Future getLokasiServis() async{
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/service-center/getAll'),
    body: {
      "type_id" : "02"
    });
    var datagetlokasi = json.decode(response.body);
    return datagetlokasi;
  }


   Future getServiceItemTrailer() async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/code-item/getAll'), body: {
      "code_id" : "9"
    });
    var dataserviceitem = json.decode(response.body);
    return dataserviceitem;
  }



  Future getListServiceHistory(String driver_id) async {

    var response = await http.get(Uri.parse('${apiconf.urlApi}api/maintenance/getHistoryMaintenanceByDriver/${driver_id}'));
    var datalisthistoryservice = json.decode(response.body);

    return datalisthistoryservice;

  }


 
// TRAILER
//Mtype - 01
  Future setMaintenanceTrailer(
    String idMaintenance,
    String idDriver,
    String idCar,
    String engineer,
    String idLokasiBengkel,
    String serDate,
    String serTime,
    String estServ,
    String estTime,
    String remark,
    String userId,
    var maintenanceDetailId
  ) async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/maintenance/store'),
    body: {
        "maintenance[id]" : "${idMaintenance}",
        "maintenance[driver_id]" : "${idDriver}",
        "maintenance[car_id]" : "${idCar}",
        "maintenance[chasis_id]" : "${idCar}",
        "maintenance[manufacture_type]" : "02",
        "maintenance[service_type]" : "01", // 01 - Servis, 03 - CHANGE, 02 - AIR
        "maintenance[service_center_id]" : "${idLokasiBengkel}",
        "maintenance[start_date]" : "${serDate} ${serTime}",
        "maintenance[est_finish_date]" : "${estServ} ${estTime}",
        "maintenance[finish_date]" : "",
        "maintenance[pot]" : "0",
        "maintenance[total_pot]" : "0",
        "maintenance[tax]" : "0",
        "maintenance[total_tax]" : "0",
        "maintenance[subtotal]" : "0",
        "maintenance[total]" : "0",
        "maintenance[pay]" : "0",
        "maintenance[change]" : "0",
        "maintenance[status]" : "01",
        "maintenance[engineer]" : "${engineer}",
        "maintenance[remark]" : "${remark}",
        "maintenance[created_by]" : "${userId}",
        "maintenance[updated_by]" : "${userId}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][service_id]" : "${maintenanceDetailId[i]}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][service_type]" : "01",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][created_by]" : "${userId}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][updated_by]" : "${userId}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][maintenance_id]" : "${idMaintenance}",
    }
    );
    return response;
  }
  //03 Mtype
   Future setMaintenanceTireTrailerAir(
    String idMaintenance,
    String idDriver,
    String idCar,
    String engineer,
    String serDate,
    String serTime,
    String estServ,
    String estTime,
    String remark,
    String userId,
    var dataTireSend
  ) async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/maintenance/store'),
    body: {
        "maintenance[id]" : "${idMaintenance}",
        "maintenance[driver_id]" : "${idDriver}",
        "maintenance[car_id]" : "${idCar}",
        "maintenance[manufacture_type]" : "02",
        "maintenance[service_type]" : "03",
        "maintenance[service_center_id]" : "1",
        "maintenance[start_date]" : "${serDate} ${serTime}",
        "maintenance[est_finish_date]" : "${estServ} ${estTime}",
        "maintenance[finish_date]" : "${serDate} ${serTime}",
        "maintenance[pot]" : "0",
        "maintenance[total_pot]" : "0",
        "maintenance[tax]" : "0",
        "maintenance[total_tax]" : "0",
        "maintenance[subtotal]" : "0",
        "maintenance[total]" : "0",
        "maintenance[pay]" : "0",
        "maintenance[change]" : "0",
        "maintenance[status]" : "03",
        "maintenance[engineer]" : "${engineer}",
        "maintenance[remark]" : "${remark}",
        "maintenance[created_by]" : "${userId}",
        "maintenance[updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][tire]" : "${dataTireSend[i]['label']}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][tire_pressure]" : "${dataTireSend[i]['value']}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][service_type]" : "03", 
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][created_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][maintenance_id]" : "${idMaintenance}",
       
    }
    );
    return response;
  }

   //02 Mtype
   Future setMaintenanceTireTrailerChange(
    String idMaintenance,
    String idDriver,
    String idCar,
    String engineer,
    String idLokasiBengkel,
    String serDate,
    String serTime,
    String estServ,
    String estTime,
    String remark,
    String userId,
    var dataTireSend
  ) async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/maintenance/store'),
    body: {
        "maintenance[id]" : "${idMaintenance}",
        "maintenance[driver_id]" : "${idDriver}",
        "maintenance[car_id]" : "${idCar}",
        "maintenance[manufacture_type]" : "02",
        "maintenance[service_type]" : "02", 
        "maintenance[service_center_id]" : "${idLokasiBengkel}",
        "maintenance[start_date]" : "${serDate} ${serTime}",
        "maintenance[est_finish_date]" : "${estServ} ${estTime}",
        "maintenance[finish_date]" : "",
        "maintenance[pot]" : "0",
        "maintenance[total_pot]" : "0",
        "maintenance[tax]" : "0",
        "maintenance[total_tax]" : "0",
        "maintenance[subtotal]" : "0",
        "maintenance[total]" : "0",
        "maintenance[pay]" : "0",
        "maintenance[change]" : "0",
        "maintenance[status]" : "01",
        "maintenance[engineer]" : "${engineer}",
        "maintenance[remark]" : "${remark}",
        "maintenance[created_by]" : "${userId}",
        "maintenance[updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][tire]" : "${dataTireSend[i]['label']}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][condition]" : "${dataTireSend[i]['value'].toString().substring(0,1)}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][service_type]" : "02",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][created_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][maintenance_id]" : "${idMaintenance}",
       
    }
    );
    return response;
  }





  //CAR
  //01 Mtype
   Future setMaintenanceCar(
    String idMaintenance,
    String idDriver,
    String idCar,
    String kilometer,
    String idLokasiBengkel,
    String engineer,
    String serDate,
    String serTime,
    String estServ,
    String estTime,
    String remark,
    String userId,
    var maintenanceDetailId
  ) async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/maintenance/store'),
    body: {
        "maintenance[id]" : "${idMaintenance}",
        "maintenance[driver_id]" : "${idDriver}",
        "maintenance[car_id]" : "${idCar}",
        "maintenance[manufacture_type]" : "01",
        "maintenance[service_type]" : "01", 
        "maintenance[service_center_id]" : "${idLokasiBengkel}",
        "maintenance[start_date]" : "${serDate} ${serTime}",
        "maintenance[est_finish_date]" : "${estServ} ${estTime}",
        "maintenance[finish_date]" : "",
        "maintenance[pot]" : "0",
        "maintenance[total_pot]" : "0",
        "maintenance[tax]" : "0",
        "maintenance[total_tax]" : "0",
        "maintenance[subtotal]" : "0",
        "maintenance[total]" : "0",
        "maintenance[pay]" : "0",
        "maintenance[change]" : "0",
        "maintenance[status]" : "01",
        "maintenance[engineer]" : "${engineer}",
        "maintenance[current_km]" : "${kilometer}",
        "maintenance[remark]" : "${remark}",
        "maintenance[created_by]" : "${userId}",
        "maintenance[updated_by]" : "${userId}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][service_id]" : "${maintenanceDetailId[i]}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][service_type]" : "01",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][created_by]" : "${userId}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][updated_by]" : "${userId}",
        for(var i = 0; i < maintenanceDetailId.length; i++)
          "maintenance_detail[${i}][maintenance_id]" : "${idMaintenance}",
    }
    );
    return response;
  }


  //03 Mtype
   Future setMaintenanceTireCarAir(
    String idMaintenance,
    String idDriver,
    String idCar,
    String engineer,
    String kilometer,
    String serDate,
    String serTime,
    String estServ,
    String estTime,
    String remark,
    String userId,
    var dataTireSend
  ) async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/maintenance/store'),
    body: {
        "maintenance[id]" : "${idMaintenance}",
        "maintenance[driver_id]" : "${idDriver}",
        "maintenance[car_id]" : "${idCar}",
        "maintenance[manufacture_type]" : "01",
        "maintenance[service_type]" : "03",
        "maintenance[service_center_id]" : "1",
        "maintenance[start_date]" : "${serDate} ${serTime}",
        "maintenance[est_finish_date]" : "${estServ} ${estTime}",
        "maintenance[finish_date]" : "${serDate} ${serTime}",
        "maintenance[pot]" : "0",
        "maintenance[total_pot]" : "0",
        "maintenance[tax]" : "0",
        "maintenance[total_tax]" : "0",
        "maintenance[subtotal]" : "0",
        "maintenance[total]" : "0",
        "maintenance[pay]" : "0",
        "maintenance[change]" : "0",
        "maintenance[status]" : "03",
        "maintenance[engineer]" : "${engineer}",
        "maintenance[current_km]" : "${kilometer}",
        "maintenance[remark]" : "${remark}",
        "maintenance[created_by]" : "${userId}",
        "maintenance[updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][tire]" : "${dataTireSend[i]['label']}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][tire_pressure]" : "${dataTireSend[i]['value']}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][service_type]" : "03",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][created_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][maintenance_id]" : "${idMaintenance}",
       
    }
    );
    return response;
  }


  //02 Mtype
   Future setMaintenanceTireCarChange(
    String idMaintenance,
    String idDriver,
    String idCar,
    String engineer,
    String idLokasiBengkel,
    String kilometer,
    String serDate,
    String serTime,
    String estServ,
    String estTime,
    String remark,
    String userId,
    var dataTireSend
  ) async {
    var response = await http.post(Uri.parse('${apiconf.urlApi}api/maintenance/store'),
    body: {
        "maintenance[id]" : "${idMaintenance}",
        "maintenance[driver_id]" : "${idDriver}",
        "maintenance[car_id]" : "${idCar}",
        "maintenance[manufacture_type]" : "01",
        "maintenance[service_type]" : "02", 
        "maintenance[service_center_id]" : "${idLokasiBengkel}",
        "maintenance[start_date]" : "${serDate} ${serTime}",
        "maintenance[est_finish_date]" : "${estServ} ${estTime}",
        "maintenance[finish_date]" : "",
        "maintenance[pot]" : "0",
        "maintenance[total_pot]" : "0",
        "maintenance[tax]" : "0",
        "maintenance[total_tax]" : "0",
        "maintenance[subtotal]" : "0",
        "maintenance[total]" : "0",
        "maintenance[pay]" : "0",
        "maintenance[change]" : "0",
        "maintenance[status]" : "01",
        "maintenance[engineer]" : "${engineer}",
        "maintenance[current_km]" : "${kilometer}",
        "maintenance[remark]" : "${remark}",
        "maintenance[created_by]" : "${userId}",
        "maintenance[updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][tire]" : "${dataTireSend[i]['label']}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][condition]" : "${dataTireSend[i]['value'].toString().substring(0,1)}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][service_type]" : "02",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][created_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][updated_by]" : "${userId}",
        for(var i = 0; i < dataTireSend.length; i++)
          "maintenance_detail[${i}][maintenance_id]" : "${idMaintenance}",
       
    }
    );
    return response;
  }





}
