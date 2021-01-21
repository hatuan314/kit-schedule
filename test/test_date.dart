import 'package:flutter_test/flutter_test.dart';

void main (){
  group("test date ", (){
    test("DateTime.now", (){
      var now = DateTime(2020,12,24) ;
      if (now.month == 12 && now.day >= 20 && now.day <= 25)
        print("Noel Time");
      else
        print("Time");
      print(now.toString());
    });
  });
}