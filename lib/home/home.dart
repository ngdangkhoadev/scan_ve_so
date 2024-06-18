import 'dart:ui';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:do_ve_so/component/ItemHome.dart';

import 'package:do_ve_so/component/home/KienThietHome.dart';
import 'package:do_ve_so/component/home/VietLotHome.dart';
import 'package:do_ve_so/mien_bac/mien_bac_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(230.h),
          child: AppBar(
            backgroundColor: Colors.amber[50],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r)),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/bghome2.png"),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            color: Colors.amber[50],
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                const KienThietHome(),
                const VietLotHome(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
