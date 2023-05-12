import 'package:flutter/material.dart';
import 'package:unjday_6april/ui_view/login_view.dart';
import 'package:unjday_6april/ui_view/view_berita.dart';
import 'package:unjday_6april/utils/session_manager.dart';

class PageSplashScreen extends StatefulWidget {
  const PageSplashScreen({Key? key}) : super(key: key);

  @override
  State<PageSplashScreen> createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen> {
  //method untuk cek sesi
  Future cekSession() async {
    Future.delayed(const Duration(seconds: 5), () {
      sessionManager.getPref().then((value) {
        print("session $value");
        //kita cek value sessionnya
        if (value != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageHomeBerita()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageLogin()),
              (route) => false);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cekSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 55,
            ),
            Image.asset(
              'gambar/logounj.png',
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Selamat Datang di Aplikasi Portal Universitas Negeri Jakarta',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '@ UNJ 2023',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
