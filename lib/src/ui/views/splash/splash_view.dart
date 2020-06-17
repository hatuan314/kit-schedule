import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/service/services.dart';
import 'package:schedule/src/ui/views/splash/box.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var brightness;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _checkIfDarkModeEnabled();
    initData().then((value) async {
      await navigateToScreen();
    });
  }

  void _checkIfDarkModeEnabled() {
    brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark)
      print("Dark mode");
    else
      print("Normal mode");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:
          brightness == Brightness.dark ? Colors.black : Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/kit_schedule_logo.png',
                  width: MediaQuery.of(context).size.width * 0.15,
                  color: Colors.white,
                ),
                SizedBox(
                  width: ScUtil.getInstance().setWidth(20),
                ),
                Text(
                  "KIT Schedule",
                  style: TextStyle(
                      fontSize: ScUtil.getInstance().setSp(50),
                      color: Colors.white,
                      fontFamily: 'MR',
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            Box()
          ],
        ),
      ),
    );
  }

  Future initData() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Future navigateToScreen() async {
    ShareService _shareService = ShareService();
    try {
      var flag = await _shareService.getIsSaveData();
      if (flag == true)
        Navigator.pushReplacementNamed(context, '/home');
      else
        Navigator.pushReplacementNamed(context, '/sign-in');
    } catch (e) {
      debugPrint('SplashView - navigateToScreen - error: {$e}');
    }

//    Navigator.pushReplacementNamed(context, '/signIn');
  }
}
