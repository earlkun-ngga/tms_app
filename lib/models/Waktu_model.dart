


class WaktuModel {


  late String tanggal;



  String getTanggalFirstFormat() {

      String tahun;
      String bulan;
      String tanggal;
      DateTime now = DateTime.now();
      String strDate = now.toString();
      String selectedDate = strDate.substring(0,10);
      String selectedTime = strDate.substring(10,19);
      
      tahun = strDate.substring(0,4);
      bulan = strDate.substring(5,7);  
      tanggal = strDate.substring(8,10);


      return '${tanggal}/${bulan}/${tahun}';
  }

   String getTanggalStripFormat() {

      String tahun;
      String bulan;
      String tanggal;
      DateTime now = DateTime.now();
      String strDate = now.toString();
      String selectedDate = strDate.substring(0,10);
      String selectedTime = strDate.substring(10,19);
      
      tahun = strDate.substring(0,4);
      bulan = strDate.substring(5,7);  
      tanggal = strDate.substring(8,10);


      return '${tahun}-${bulan}-${tanggal}';
  }

   String getTanggalSecondFormat() {

      String tahun;
      String bulan;
      String tanggal;
      DateTime now = DateTime.now();
      String strDate = now.toString();
       String selectedDate = strDate.substring(0,10);
      String selectedTime = strDate.substring(10,19);


      tahun = strDate.substring(0,4);
      bulan = strDate.substring(5,7);  
      tanggal = strDate.substring(8,10);


      return '${selectedDate} ${selectedTime}';
  }

   String getTimeFirstFormat() {

      String tahun;
      String bulan;
      String tanggal;
      DateTime now = DateTime.now();
      String strDate = now.toString();
       String selectedDate = strDate.substring(0,10);
      String selectedTime = strDate.substring(10,19);


      tahun = strDate.substring(0,4);
      bulan = strDate.substring(5,7);  
      tanggal = strDate.substring(8,10);


      return '${selectedTime}';
  }


}