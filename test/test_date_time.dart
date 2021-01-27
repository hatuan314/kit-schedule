import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main(){
  DateTime now = DateTime.now();
  group("Test Date - Time", (){
    test("Test Date", (){
      DateTime dateNow = DateTime(now.year,now.month,now.day);
      int dateMicro = dateNow.microsecondsSinceEpoch;
      print('date : ${DateFormat('yyyy-MM-dd').format(dateNow)}');
      print('date microseconds : $dateMicro');
      expect(dateNow, DateTime.fromMicrosecondsSinceEpoch(dateMicro));
    });
    test("Test Time", (){
      DateTime time = DateTime(now.hour,now.minute);
      int timeMicro = time.microsecondsSinceEpoch;
      print('Time  : ${DateFormat('kk:mm').format(time)}');
      print('time microseconds : $timeMicro');
      expect(time, DateTime.fromMicrosecondsSinceEpoch(timeMicro));
    });
    test("Test String date time to DatTime", (){
      String date = '2021-01-21';
      String time = '14:13';
      DateTime dateTime = DateTime.parse('${date}T$time');
      expect(now, dateTime);
    });
  });
}