import 'package:compound_interest_flutter_app/page/compound_interest_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CompoundInterestView(),
    );
  }
}

