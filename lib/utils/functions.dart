import 'package:flutter/material.dart';

void openPage({required BuildContext context,required Widget page}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}
