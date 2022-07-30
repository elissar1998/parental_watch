import 'selection_home_page.dart';
import 'package:parental_watch_backend/utils/functions.dart';
import 'package:flutter/material.dart';


class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      openPage(context: context, page:SelectionHomePage())  ;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[50],
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),

            Text("KidSafe",style: TextStyle(

              color: Colors.indigoAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),)

          ],
        ),
      ),
    );
  }
}

