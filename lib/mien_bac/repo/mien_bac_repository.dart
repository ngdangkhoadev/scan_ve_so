import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

enum StatusInitialMienBac { initial, success, failure }

enum StatusMienBac { unknown, isProcessing, success, failure }

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
