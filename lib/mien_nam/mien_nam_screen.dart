import 'dart:developer';
import 'package:do_ve_so/component/config/const.dart';
import 'package:do_ve_so/mien_bac/mien_bac_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class MienNamScreen extends StatefulWidget {
  const MienNamScreen({super.key});

  @override
  State<MienNamScreen> createState() => _MienNamScreenState();
}

class _MienNamScreenState extends State<MienNamScreen> {
  late Future<List<Map<String, dynamic>>> _fetchLotteryResults;
  String? selectedNgay;
  String? selectedProvince;
  late List<Map<String, dynamic>> allResults = [];

  @override
  void initState() {
    super.initState();
    _fetchLotteryResults = fetchLotteryResults();
  }

  Future<List<Map<String, dynamic>>> fetchLotteryResults() async {
    final response = await http
        .get(Uri.parse('https://xskt.com.vn/rss-feed/mien-nam-xsmn.rss'));
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

  Map<String, Map<String, List<String>>> _parsePrizes(String description) {
    final prizes = <String, Map<String, List<String>>>{};
    const provincePattern = ('['); // Pattern to find province names
    final prizeLines = description.split(provincePattern);

    for (String line in prizeLines) {
      if (line.trim().isEmpty) continue;

      List<String> parts = line.split(']');
      String regionName = parts[0].trim();
      String dataPart = parts[1].trim();
      dataPart = dataPart.replaceAll("8:", " 8:");
      prizes[regionName] = <String, List<String>>{};
      List<String> entries = dataPart.split(RegExp(r'\s(?=\d+:|\d+-)'));
      print(regionName);
      for (String entry in entries) {
        if (entry.contains(':')) {
          List<String> keyValue = entry.split(':');
          String key = keyValue[0].trim();
          String value = keyValue[1].trim();
          if (value.contains('-')) {
            prizes[regionName]![key] =
                value.split(' - ').map((e) => e.trim()).toList();
          } else {
            prizes[regionName]![key] = [value];
          }
        }
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
          title: const Text("Xổ Số Miền Nam"),
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
              final dates =
                  allResults.map((result) => result['ngay'] as String).toList();

              // Đảm bảo selectedNgay được đặt ban đầu là mục đầu tiên
              selectedNgay ??= dates.first;

              // Lấy kết quả xổ số cho ngày đã chọn
              final selectedResult = allResults.firstWhere(
                (result) => result['ngay'] == selectedNgay,
              );

              final prizes = selectedResult['prizes']
                  as Map<String, Map<String, List<String>>>;

              // Lấy danh sách các tỉnh/thành phố
              final provincesList = prizes.keys.toList();

              // Đặt selectedProvince mặc định là tỉnh đầu tiên của ngày đã chọn
              selectedProvince ??= provincesList.first;

              // Lọc prizes dựa trên tỉnh/thành phố đã chọn
              final filteredPrizes = selectedProvince != null
                  ? {selectedProvince!: prizes[selectedProvince!]}
                  : prizes;

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
                              // Cập nhật tỉnh đầu tiên của ngày đã chọn
                              final updatedResult = allResults.firstWhere(
                                (result) => result['ngay'] == selectedNgay,
                              );
                              final updatedProvincesList =
                                  updatedResult['prizes'].keys.toList();
                              selectedProvince = updatedProvincesList.first;
                            });
                          },
                          items: dates.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                        const SizedBox(height: 10),
                        const Text("Chọn tỉnh/thành phố"),
                        DropdownButton<String>(
                          value: selectedProvince,
                          hint: const Text('Chọn tỉnh/thành phố'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedProvince = newValue!;
                            });
                          },
                          items: provincesList.map<DropdownMenuItem<String>>(
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
                          children: filteredPrizes.entries.expand((entry) {
                            return entry.value!.entries
                                .mapIndexed((index, prizeEntry) {
                              final isEven = index % 2 == 0;
                              final isFirstRow = index == 0;
                              final isLastRow =
                                  index == entry.value!.length - 1;

                              return TableRow(
                                decoration: BoxDecoration(
                                  color:
                                      isEven ? Colors.grey[200] : Colors.white,
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
                                            prizeEntry.key,
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
                                    children: prizeEntry.value
                                        .map((number) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                number,
                                                style: isFirstRow || isLastRow
                                                    ? styleTitleBigItem
                                                    : styleTitleSmallItem,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              );
                            }).toList();
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
