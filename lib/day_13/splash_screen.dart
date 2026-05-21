import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/constant/app_color.dart';
import 'package:ppkd_b6/day_14/login_screen.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class SplashScreenDay13 extends StatelessWidget {
  const SplashScreenDay13({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/images/kucing_3.jpeg")),
          // kIsWeb
          //     ? TextButton(
          //         onPressed: () {
          //           // context.pushNamed("/login");
          //           // context.push(TextRichDay13());
          //           // context.push(TextFormDay13());
          //           context.push(LoginScreenDay14());
          //         },
          //         child: Text(
          //           "Ke halaman login",
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       )
          //     : Platform.isIOS
          //     ?
          kIsWeb
              ? SizedBox(
                  width: MediaQuery.of(context).size.width > 1000
                      ? 500
                      : double.infinity,
                  child: TextField(),
                )
              : TextField(),
          CupertinoButton(
            color: AppColor.blueButton,
            onPressed: () {
              // context.pushNamed("/login");
              // context.push(TextRichDay13());
              // context.push(TextFormDay13());
              context.push(LoginScreenDay14());
            },
            child: Text(
              "Ke halaman login",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // : ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColor.blueButton,
          //     ),
          //     onPressed: () {
          //       // context.pushNamed("/login");
          //       // context.push(TextRichDay13());
          //       // context.push(TextFormDay13());
          //       context.push(LoginScreenDay14());
          //     },
          //     child: Text(
          //       "Ke halaman login",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
