import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:community_material_icon/community_material_icon.dart';
import 'package:do_ve_so/component/DateInputWidget.dart';
import 'package:do_ve_so/component/Dropdown.dart';
import 'package:do_ve_so/component/XoSo.dart';
import 'package:do_ve_so/component/config/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MienNamScreen extends StatefulWidget {
  const MienNamScreen({super.key});

  @override
  State<MienNamScreen> createState() => _MienNamScreenState();
}

class _MienNamScreenState extends State<MienNamScreen> {
  Future<List<Map<String, dynamic>>> fetchLotteryResults() async {
    final response = await http
        .get(Uri.parse('https://xskt.com.vn/rss-feed/mien-nam-xsmn.rss'));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      return items.map((item) {
        final title = item.findElements('title').single.text;
        final description = item.findElements('description').single.text;
        final link = item.findElements('link').single.text;
        final pubDate = item.findElements('pubDate').single.text;
        final prizes = _parsePrizes(description);

        return {
          'title': title,
          'prizes': prizes,
          'link': link,
          'pubDate': pubDate,
        };
      }).toList();
    } else {
      throw Exception('Failed to load lottery results');
    }
  }

  Map<String, Map<String, List<String>>> _parsePrizes(String description) {
    final prizeLines = description.trim().split('[');
    final prizes = <String, Map<String, List<String>>>{};

    for (var line in prizeLines) {
      if (line.contains(']')) {
        final parts = line.split(']');
        final region = parts[0].trim();
        final prizeData = parts[1].trim().split('\n');
        final regionPrizes = <String, List<String>>{};

        for (var prizeLine in prizeData) {
          final prizeParts = prizeLine.split(':');
          if (prizeParts.length == 2) {
            final prizeType = prizeParts[0].trim();
            final prizeNumbers = prizeParts[1].trim().split(' - ');
            regionPrizes[prizeType] = prizeNumbers;
          }
        }
        prizes[region] = regionPrizes;
      }
    }

    return prizes;
  }

  String? selectedTinh;
  final TextEditingController DateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Xổ Số Miền Nam"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
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
                      image: const DecorationImage(
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
                            image: const AssetImage(
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
                                            decoration: const BoxDecoration(
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
                                    items: const [
                                      'Tỉnh',
                                      'Tỉnh',
                                      'Tỉnh',
                                      'Tỉnh'
                                    ],
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
                                    child: const Text(
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
                      color: const Color.fromARGB(158, 158, 158, 158)),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(64),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        SizedBox(
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
                              "TP Hồ Chí Minh",
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
                              "Cà Mau",
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
                              "Sóc Trăng",
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
                        SizedBox(
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
                                child: const Text(
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
                        Container(
                          child: Center(
                            child: Text("99", style: styleTitleBigItem),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        SizedBox(
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
                                child: const Text(
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
                        Container(
                          child: Center(
                            child: Text(
                              "999",
                              style: TextStyle(
                                  fontSize: 25.sp,
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
                        SizedBox(
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
                                child: const Text(
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
                        SizedBox(
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
                                child: const Text(
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
                        SizedBox(
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
                                child: const Text(
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
                        SizedBox(
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
                                child: const Text(
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
                        SizedBox(
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
                                child: const Text(
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
                        Container(
                          child: Center(
                            child: Text("99999", style: styleTitleSmallItem),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        SizedBox(
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
                                child: const Text(
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
                        SizedBox(
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
                                child: const Text(
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
