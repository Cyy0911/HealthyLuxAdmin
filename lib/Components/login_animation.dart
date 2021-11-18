// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

// class LoginFadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;

//   const LoginFadeAnimation(this.delay, this.child, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final tween = ([
//       Tween("opacity")
//           .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
//       Tween("translateY").add(
//           Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
//           curve: Curves.easeOut)
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(0, animation["translateY"]), child: child),
//       ),
//     );
//   }
// }
