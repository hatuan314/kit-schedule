// import 'package:flutter/material.dart';
// import 'package:schedule/ui/views/splash/typewriter_text.dart';
// import 'package:simple_animations/simple_animations/controlled_animation.dart';
//
// class Box extends StatelessWidget {
//   static final boxDecoration = BoxDecoration(
// //      color: Colors.orange,
//     borderRadius: BorderRadius.all(Radius.circular(10)),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return ControlledAnimation(
//       duration: Duration(milliseconds: 400),
//       tween: Tween(begin: 0.0, end: 80.0),
//       builder: (context, dynamic height) {
//         return ControlledAnimation(
//           duration: Duration(milliseconds: 1200),
//           delay: Duration(milliseconds: 500),
//           tween: Tween(begin: 2.0, end: 300.0),
//           builder: (context, dynamic width) {
//             return Container(
//               decoration: boxDecoration,
//               width: width,
//               height: height,
//               child: isEnoughRoomForTypewriter(width)
//                   ? Text('Welcome !')//TypewriterText("Welcome !")//todo
//                   : Container(),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   isEnoughRoomForTypewriter(width) => width > 20;
// }
