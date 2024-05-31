import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MienBacScreen extends StatelessWidget {
  const MienBacScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          
          title: Text("Xổ Số Miền Bắc"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xfffed758),
                Color(0xffffb653),
                Color(0xffffa04e),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/bg.jpg"),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: REdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      Center(
                        child: Image(
                          height: 100.h,
                          width: 300.w,
                          image: AssetImage(
                              "assets/images/kk-removebg-preview.png"),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 20.sp),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: REdgeInsets.all(15.0.sp),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 8,
                                      child: TextFormField(
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.number,
                                        //bắt sự kiện nhập
                                        maxLines: null,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black),
                                        cursorColor: Colors.black,

                                        decoration: InputDecoration(
                                          isDense: true,
                                          fillColor: Colors.white,
                                          hintText: "Nhập 6 số trên vé",
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              borderSide: BorderSide(
                                                  width: 0.7.w,
                                                  color: Colors.grey.shade500)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              borderSide: BorderSide(
                                                  width: 0.7.w,
                                                  color: Colors.grey.shade500)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              borderSide: BorderSide(
                                                  width: 0.7.w,
                                                  color: Colors.grey.shade500)),
                                          hintStyle: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey),
                                          contentPadding: REdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 12.h),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                        flex: 2,
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/qr-scan.png"))),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.number,
                                  //bắt sự kiện nhập
                                  maxLines: null,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.black),
                                  cursorColor: Colors.black,

                                  decoration: InputDecoration(
                                    isDense: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            width: 0.7.w,
                                            color: Colors.grey.shade500)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            width: 0.7.w,
                                            color: Colors.grey.shade500)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            width: 0.7.w,
                                            color: Colors.grey.shade500)),
                                    hintStyle: TextStyle(
                                        fontSize: 12.sp, color: Colors.grey),
                                    contentPadding: REdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.number,
                                  //bắt sự kiện nhập
                                  maxLines: null,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.black),
                                  cursorColor: Colors.black,

                                  decoration: InputDecoration(
                                    counterText: '',
                                    isDense: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            width: 0.7.w,
                                            color: Colors.grey.shade500)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            width: 0.7.w,
                                            color: Colors.grey.shade500)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            width: 0.7.w,
                                            color: Colors.grey.shade500)),
                                    hintStyle: TextStyle(
                                        fontSize: 12.sp, color: Colors.grey),
                                    contentPadding: REdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle button press
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 98, 7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5.0.r), // Adjust the border radius
                                    ),
                                  ),
                                  child: Text(
                                      "Dò nhanh"), // Text inside the button
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
