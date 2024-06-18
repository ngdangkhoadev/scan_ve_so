import 'dart:io';

import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:do_ve_so/home/home.dart';
import 'package:do_ve_so/info/info.dart';

import 'package:do_ve_so/scan/scan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({super.key});

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  File? selectedMedia;

  void onPressed() async {
    try {
      final pictures = await CunningDocumentScanner.getPictures(
              isGalleryImportAllowed: true) ??
          [];
      if (!mounted) return;
      setState(() {
        selectedMedia = File(pictures.join());
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanScreen(imageFile: selectedMedia!),
        ),
      );
    } catch (exception) {
      // Handle exception here
    }
  }

  int _selectedIndex = 0;
  // ignore: unused_field

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: Colors.white,
        unSelectedColor: Colors.black54,
        backgroundColor: Colors.amber,
        currentIndex: _selectedIndex,
        unselectedIconSize: 15.sp,
        selectedIconSize: 25.sp,
        onTap: _onItemTapped,
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.bottom,
        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Trang chủ',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Cài đặt',
            icon: Icons.settings,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(builder: (context) {
        return SizedBox(
          height: 80.0.h, //
          width: 80.0.w, //
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const ScanScreen()),
              //   );
              // },
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 4.w,
                  color: Colors.yellow,
                ),
                borderRadius: BorderRadius.circular(50.sp),
              ),
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/qr-scan.png"))),
              )),
        );
      }),
    );
  }
}
