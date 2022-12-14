import 'package:flutter/material.dart';
import 'package:parental_watch_backend/pages/child.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parental_watch_backend/pages/selection_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SelectionHomePage(),
    );
  }
}
