import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:do_ve_so/component/DateInputWidget.dart';
import 'package:do_ve_so/component/Dropdown.dart';
import 'package:do_ve_so/component/config/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MienBacScreen extends StatefulWidget {
  const MienBacScreen({super.key});

  @override
  State<MienBacScreen> createState() => _MienBacScreenState();
}

class _MienBacScreenState extends State<MienBacScreen> {
  String? enteredValue;
  String? selectedTinh;
  final TextEditingController DateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<List<Map<String, dynamic>>> fetchLotteryResults() async {
    final response = await http
        .get(Uri.parse('https://xskt.com.vn/rss-feed/mien-bac-xsmb.rss'));

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

  Map<String, List<String>> _parsePrizes(String description) {
    final prizeLines = description.trim().split('\n');
    final prizes = <String, List<String>>{};

    for (var line in prizeLines) {
      final parts = line.split(':');
      if (parts.length == 2) {
        final prizeType = parts[0].trim();
        final prizeNumbers = parts[1].trim().split(' - ');
        prizes[prizeType] = prizeNumbers;
      }
    }

    return prizes;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstAllowedDate = now.subtract(const Duration(days: 10));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstAllowedDate,
      lastDate: now,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Xổ Số Miền Bắc"),
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
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchLotteryResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No lottery results found'));
            } else {
              final results = snapshot.data!.where((result) {
                final pubDate = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz')
                    .parse(result['pubDate']);
                return pubDate.year == selectedDate.year &&
                    pubDate.month == selectedDate.month &&
                    pubDate.day == selectedDate.day;
              }).toList();

              if (results.isEmpty) {
                return const Center(
                    child: Text('No lottery results for the selected date'));
              }

              final result = results.first;
              final title = result['title'] as String;
              final prizes = result['prizes'] as Map<String, List<String>>;
              return SingleChildScrollView(
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
                                padding:
                                    REdgeInsets.symmetric(horizontal: 20.sp),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
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
                                                onChanged: (value) {
                                                  enteredValue =
                                                      value; // Lưu trữ giá trị nhập từ TextFormField
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLines: null,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                ),
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  fillColor: Colors.white,
                                                  hintText: "Nhập 5 số trên vé",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    borderSide: BorderSide(
                                                      width: 0.7.w,
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                                  ),
                                                  // Các thuộc tính khác...
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
                                            if (enteredValue != null) {
                                              bool found = false;
                                              for (var entry
                                                  in prizes.entries) {
                                                if (entry.value
                                                    .contains(enteredValue)) {
                                                  found = true;
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          'Thông báo'),
                                                      content: Text(
                                                          'Giá trị nhập $enteredValue được tìm thấy trong bảng.'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Đóng'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  // Thực hiện hành động khi tìm thấy giá trị
                                                  break;
                                                }
                                              }
                                              if (!found) {
                                                // Nếu giá trị không được tìm thấy trong bảng, hiển thị thông báo cho người dùng
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title:
                                                        const Text('Thông báo'),
                                                    content: Text(
                                                        'Giá trị nhập $enteredValue không được tìm thấy trong bảng.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('Đóng'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 98, 7),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0
                                                      .r), // Adjust the border radius
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
                      // Table(
                      //   border: TableBorder.all(
                      //       color: const Color.fromARGB(158, 158, 158, 158)),
                      //   columnWidths: const <int, TableColumnWidth>{
                      //     0: FixedColumnWidth(64),
                      //     1: FlexColumnWidth(),
                      //   },
                      //   defaultVerticalAlignment:
                      //       TableCellVerticalAlignment.middle,
                      //   children: prizes.entries.mapIndexed((index, entry) {
                      //     final isEven = index % 2 == 0;
                      //     final isFirstRow = index == 0;
                      //     final isLastRow = index == prizes.length - 1;

                      //     return TableRow(
                      //       decoration: BoxDecoration(
                      //         color: isEven ? Colors.grey[200] : Colors.white,
                      //       ),
                      //       children: <Widget>[
                      //         SizedBox(
                      //           height: 50,
                      //           width: 64,
                      //           child: Center(
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: Colors.red,
                      //                 borderRadius: BorderRadius.circular(5.0),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                   vertical: 5.0,
                      //                   horizontal: 10.0,
                      //                 ),
                      //                 child: Text(
                      //                   entry.key,
                      //                   style: const TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Container(
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceEvenly,
                      //             children: entry.value.map((number) {
                      //               TextStyle textStyle;
                      //               if (isFirstRow) {
                      //                 textStyle = styleTitleBigItem;
                      //               } else if (isLastRow) {
                      //                 textStyle = styleTitleBigItem;
                      //               } else {
                      //                 textStyle = isEven
                      //                     ? styleTitleSmallItem
                      //                     : styleTitleSmallItem;
                      //               }

                      //               return Text(
                      //                 number,
                      //                 style: textStyle,
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   }).toList(),
                      // )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E e) f) {
    int index = 0;
    return map((e) => f(index++, e));
  }
}
