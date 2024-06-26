import 'dart:math';

import 'package:do_ve_so/component/config/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class MienBacScreen extends StatefulWidget {
  const MienBacScreen({super.key});

  @override
  State<MienBacScreen> createState() => _MienBacScreenState();
}

class _MienBacScreenState extends State<MienBacScreen> {
  late Future<List<Map<String, dynamic>>> _fetchLotteryResults;
  String? selectedNgay;
  late List<Map<String, dynamic>> allResults = [];

  @override
  void initState() {
    super.initState();
    _fetchLotteryResults = fetchLotteryResults();
  }

  Future<List<Map<String, dynamic>>> fetchLotteryResults() async {
    final response = await http
        .get(Uri.parse('https://xskt.com.vn/rss-feed/mien-bac-xsmb.rss'));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      return items.map((item) {
        final title = item.findElements('title').single.innerText;
        final ngay = extractDateFromTitle(title);
        final description = item.findElements('description').single.innerText;
        final link = item.findElements('link').single.innerText;
        final pubDate = item.findElements('pubDate').single.innerText;
        final prizes = _parsePrizes(description);

        return {
          'ngay': ngay,
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

  String extractDateFromTitle(String title) {
    int startIndex = title.indexOf("NGÀY");
    if (startIndex != -1) {
      return title.substring(startIndex).trim();
    }
    return title;
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
              gradient: LinearGradient(
                colors: [
                  Color(0xfffed758),
                  Color(0xffffb653),
                  Color(0xffffa04e),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchLotteryResults,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No lottery results found'));
            } else {
              allResults = snapshot.data!;
              print('Snapshot Data: ${snapshot.data}');
              final provinces =
                  allResults.map((result) => result['ngay'] as String).toList();

              // Ensure selectedNgay is initially set to the first item
              selectedNgay ??= provinces.first;

              final selectedResult = allResults.firstWhere(
                (result) => result['ngay'] == selectedNgay,
              );

              final prizes =
                  selectedResult['prizes'] as Map<String, List<String>>;

              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Chọn ngày quay số"),
                        DropdownButton<String>(
                          value: selectedNgay,
                          hint: const Text('Chọn ngày'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNgay = newValue!;
                            });
                          },
                          items: provinces.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                        const SizedBox(height: 10),
                        Table(
                          border: TableBorder.all(
                            color: const Color.fromARGB(158, 158, 158, 158),
                          ),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(64),
                            1: FlexColumnWidth(),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: prizes.entries.mapIndexed((index, entry) {
                            final isEven = index % 2 == 0;
                            final isFirstRow = index == 0;
                            final isLastRow = index == prizes.length - 1;

                            return TableRow(
                              decoration: BoxDecoration(
                                color: isEven ? Colors.grey[200] : Colors.white,
                              ),
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  width: 64,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5.0,
                                          horizontal: 10.0,
                                        ),
                                        child: Text(
                                          entry.key,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 10,
                                  spacing: 40,
                                  children: entry.value.map((number) {
                                    TextStyle textStyle;
                                    if (isFirstRow || isLastRow) {
                                      textStyle = styleTitleBigItem;
                                    } else {
                                      textStyle = styleTitleSmallItem;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        number,
                                        style: textStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
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
