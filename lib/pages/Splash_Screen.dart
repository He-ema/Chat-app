import 'package:chatapp/constants.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splasher extends StatefulWidget {
  Splasher({super.key});
  static String id = 'Splasher';
  @override
  State<Splasher> createState() => _SplasherState();
}

class _SplasherState extends State<Splasher> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) => LoginPage(),
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
            ),
            Text(
              'Scholar Chat',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Pacifico', fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            SpinKitSquareCircle(
              color: KPrimaryColor,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
