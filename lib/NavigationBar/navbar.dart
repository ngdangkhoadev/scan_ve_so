import 'dart:io';

import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:do_ve_so/home/home.dart';
import 'package:do_ve_so/info/info.dart';
import 'package:do_ve_so/mien_bac/mien_bac_screen.dart';
import 'package:do_ve_so/scan/scan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({super.key});

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  void getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
      }
    } catch (e) {
      textScanning = true;
      imageFile = null;
      setState(() {
        scannedText = "Error occured while scanning";
      });
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
        return Container(
          height: 80.0.h, //
          width: 80.0.w, //
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
                // showModalBottomSheet<void>(
                //   context: context,
                //   isScrollControlled: true,
                //   builder: (BuildContext context) {
                //     return Container(
                //       height: 700.h,
                //       decoration: BoxDecoration(
                //         borderRadius:
                //             BorderRadius.vertical(top: Radius.circular(20.r)),
                //         color: Colors.white,
                //       ),
                //       child: Column(
                //         children: [
                //           Expanded(
                //               flex: 8,
                //               child: Container(
                //                 child: Padding(
                //                   padding: REdgeInsets.symmetric(
                //                       horizontal: 10.r, vertical: 30.h),
                //                   child: Container(
                //                     color: Colors.grey[200],
                //                   ),
                //                 ),
                //               )),
                //           Flexible(
                //             flex: 2,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Container(
                //                   height: 100,
                //                   width: 100,
                //                   color: Colors.amber,
                //                 ),
                //                 // Container(
                //                 //   decoration: BoxDecoration(
                //                 //     borderRadius: BorderRadius.circular(10),
                //                 //     color: Colors.amber,
                //                 //     boxShadow: [
                //                 //       BoxShadow(
                //                 //         color: Colors.grey.withOpacity(0.5),
                //                 //         spreadRadius: 5,
                //                 //         blurRadius: 7,
                //                 //         offset: Offset(0,
                //                 //             3), // changes position of shadow
                //                 //       ),
                //                 //     ],
                //                 //   ),
                //                 //   child: Padding(
                //                 //     padding: REdgeInsets.all(8.0.r),
                //                 //     child: Column(
                //                 //       children: [
                //                 //         Container(
                //                 //           height: 50.h,
                //                 //           width: 50.w,
                //                 //           decoration: BoxDecoration(
                //                 //               image: DecorationImage(
                //                 //                   image: AssetImage(
                //                 //                       "assets/images/photo.png"))),
                //                 //         ),
                //                 //         Text("Thư viện")
                //                 //       ],
                //                 //     ),
                //                 //   ),
                //                 // ),
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(10),
                //                     color: Colors.white,
                //                     boxShadow: [
                //                       BoxShadow(
                //                         color: Colors.grey.withOpacity(0.5),
                //                         spreadRadius: 5,
                //                         blurRadius: 7,
                //                         offset: Offset(
                //                             0, 3), // changes position of shadow
                //                       ),
                //                     ],
                //                   ),
                //                   child: Padding(
                //                     padding: REdgeInsets.all(8.0.r),
                //                     child: Column(
                //                       children: [
                //                         Container(
                //                           height: 50.h,
                //                           width: 50.w,
                //                           decoration: BoxDecoration(
                //                               image: DecorationImage(
                //                                   image: AssetImage(
                //                                       "assets/images/pick_photo.png"))),
                //                         ),
                //                         Text("Máy ảnh")
                //                       ],
                //                     ),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // );
              },
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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/qr-scan.png"))),
              )),
        );
      }),
    );
  }
}
