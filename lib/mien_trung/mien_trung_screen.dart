import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:do_ve_so/component/DateInputWidget.dart';
import 'package:do_ve_so/component/Dropdown.dart';
import 'package:do_ve_so/component/XoSo.dart';
import 'package:do_ve_so/component/config/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MienTrungScreen extends StatefulWidget {
  const MienTrungScreen({super.key});

  @override
  State<MienTrungScreen> createState() => _MienTrungScreenState();
}

class _MienTrungScreenState extends State<MienTrungScreen> {
  String? selectedTinh;
  final TextEditingController DateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Xổ Số Miền Trung"),
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
        body: SingleChildScrollView(
          child: Container(
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
                                                    color:
                                                        Colors.grey.shade500)),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                borderSide: BorderSide(
                                                    width: 0.7.w,
                                                    color:
                                                        Colors.grey.shade500)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                borderSide: BorderSide(
                                                    width: 0.7.w,
                                                    color:
                                                        Colors.grey.shade500)),
                                            hintStyle: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey),
                                            contentPadding:
                                                REdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 15.h),
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
                                  DateInputWidget(
                                      hintext: "Chọn ngày sổ",
                                      controller: DateController,
                                      onChanged: (z) {}),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CustomDropdownWidget(
                                    selectedValue: selectedTinh,
                                    items: ['Tỉnh', 'Tỉnh', 'Tỉnh', 'Tỉnh'],
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTinh = newValue;
                                      });
                                    },
                                    hintText: 'Chọn đài',
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
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 30.r),
                  child: DateInputWidget(
                      hintext: "Chọn ngày sổ",
                      controller: DateController,
                      onChanged: (z) {}),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Table(
                  border: TableBorder.all(
                      color: Color.fromARGB(158, 158, 158, 158)),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(64),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Text(
                              "Giải",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Thừ Thiên Huế",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Phú Yên",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G8",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "99",
                              style: styleTitleBigItem,
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text("99", style: styleTitleBigItem),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G7",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "999",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "999",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G6",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("9999", style: styleTitleSmallItem),
                              Text("9999", style: styleTitleSmallItem),
                              Text("9999", style: styleTitleSmallItem),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("9999", style: styleTitleSmallItem),
                              Text("9999", style: styleTitleSmallItem),
                              Text("9999", style: styleTitleSmallItem),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G5",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text("9999", style: styleTitleSmallItem),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text("9999", style: styleTitleSmallItem),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G4",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Column(
                              children: [
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Column(
                              children: [
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G3",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Column(
                              children: [
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Column(
                              children: [
                                Text("99999", style: styleTitleSmallItem),
                                Text("99999", style: styleTitleSmallItem),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G2",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text("99999", style: styleTitleSmallItem),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text("99999", style: styleTitleSmallItem),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "G1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text("99999", style: styleTitleSmallItem),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text("99999", style: styleTitleSmallItem),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: <Widget>[
                        Container(
                          height: 50.h,
                          width: 64.w,
                          child: Container(
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: REdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.r),
                                child: Text(
                                  "ĐB",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Center(
                              child: Text("999999", style: styleTitleBigItem),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Center(
                              child: Text("999999", style: styleTitleBigItem),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
