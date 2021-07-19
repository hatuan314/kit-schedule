// import 'package:flutter/material.dart';
// import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
// //import 'package:simple_animations/simple_animations/controlled_animation.dart';
//
// class TypewriterText extends StatelessWidget {
//   final String text;
//
//   TypewriterText(this.text);
//
//   @override
//   Widget build(BuildContext context) {
//     // ignore: non_constant_identifier_names
//     TextStyle TEXTSTYLE = TextStyle(
//         letterSpacing: 5,
//         fontSize: ScUtil.getInstance()!.setSp(45),
// //        fontWeight: FontWeight.w300,
//         fontFamily: 'MR',
//         color: Colors.white);
//     return ControlledAnimation(
//         duration: Duration(milliseconds: 800),
//         delay: Duration(milliseconds: 800),
//         tween: IntTween(begin: 0, end: text.length),
//         builder: (context, dynamic textLength) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(text.substring(0, textLength), style: TEXTSTYLE),
//               ControlledAnimation(
//                 playback: Playback.LOOP,
//                 duration: Duration(milliseconds: 600),
//                 tween: IntTween(begin: 0, end: 1),
//                 builder: (context, dynamic oneOrZero) {
//                   return Opacity(
//                       opacity: oneOrZero == 1 ? 1.0 : 0.0,
//                       child: Text("_", style: TEXTSTYLE));
//                 },
//               )
//             ],
//           );
//         });
//   }
// }
