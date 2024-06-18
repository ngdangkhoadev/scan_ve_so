import 'package:do_ve_so/NavigationBar/navbar.dart';
import 'package:do_ve_so/component/config/test.dart';
import 'package:do_ve_so/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
            debugShowCheckedModeBanner: false, home: NavigationHome()));
  }
}
