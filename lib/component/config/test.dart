// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:image_picker/image_picker.dart';

// class MyAppBody extends StatefulWidget {
//   const MyAppBody({super.key});

//   @override
//   _MyAppBodyState createState() => _MyAppBodyState();
// }

// class _MyAppBodyState extends State<MyAppBody> {
//   DateTime selectedDate =
//       DateTime.now().subtract(const Duration(days: 9)); // Default start date
//   List<Map<String, dynamic>> prizesData = [];
//   final ImagePicker _picker = ImagePicker();

//   Future<void> fetchPrizesData() async {
//     String url =
//         "https://apixsmb.onrender.com/api/v1?start_date=${selectedDate.toIso8601String()}";
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       List<Map<String, dynamic>> data = [];
//       for (var item in jsonData) {
//         if (item.containsKey("date") && item["date"] is String) {
//           data.add({
//             "date": item["date"],
//             "prizes": List<String>.from(item["prizes"]["ĐB"])
//               ..addAll(List<String>.from(item["prizes"]["G1"]))
//               ..addAll(List<String>.from(item["prizes"]["G2"]))
//               ..addAll(List<String>.from(item["prizes"]["G3"]))
//               ..addAll(List<String>.from(item["prizes"]["G4"]))
//               ..addAll(List<String>.from(item["prizes"]["G5"]))
//               ..addAll(List<String>.from(item["prizes"]["G6"]))
//               ..addAll(List<String>.from(item["prizes"]["G7"])),
//           });
//         }
//       }
//       setState(() {
//         prizesData = data;
//       });
//     } else {
//       print("Failed to fetch data");
//     }
//   }

//   Future<void> scanTicket() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       final inputImage = InputImage.fromFilePath(pickedFile.path);
//       final textRecognizer = GoogleMlKit.vision.textRecognizer();
//       final RecognizedText recognizedText =
//           await textRecognizer.processImage(inputImage);
//       await textRecognizer.close();

//       String scannedNumbers =
//           recognizedText.text.replaceAll(RegExp(r'\s+'), '');
//       _checkTicket(scannedNumbers);
//     }
//   }

//   void _checkTicket(String scannedNumbers) {
//     List<Map<String, String>> winningDetails = [];

//     for (var data in prizesData) {
//       String date = data["date"];
//       Map<String, List<String>> prizes = {
//         "GĐ": data["prizes"].sublist(0, 1),
//         "G1": data["prizes"].sublist(1, 2),
//         "G2": data["prizes"].sublist(2, 3),
//         "G3": data["prizes"].sublist(3, 4),
//         "G4": data["prizes"].sublist(4, 5),
//         "G5": data["prizes"].sublist(5, 6),
//         "G6": data["prizes"].sublist(6, 7),
//         "G7": data["prizes"].sublist(7, 8),
//       };

//       for (var prizeCategory in prizes.keys) {
//         List<String> prizeNumbers = prizes[prizeCategory] ?? [];
//         for (var prizeNumber in prizeNumbers) {
//           if (prizeCategory == "GĐ" ||
//               prizeCategory == "G1" ||
//               prizeCategory == "G2" ||
//               prizeCategory == "G3") {
//             if (scannedNumbers.substring(scannedNumbers.length - 5) ==
//                 prizeNumber) {
//               winningDetails.add({
//                 "date": date,
//                 "prize": prizeNumber,
//                 "category": prizeCategory
//               });
//             }
//           } else if (prizeCategory == "G4" || prizeCategory == "G5") {
//             if (scannedNumbers.substring(scannedNumbers.length - 4) ==
//                 prizeNumber) {
//               winningDetails.add({
//                 "date": date,
//                 "prize": prizeNumber,
//                 "category": prizeCategory
//               });
//             }
//           } else if (prizeCategory == "G6") {
//             if (scannedNumbers.substring(scannedNumbers.length - 3) ==
//                 prizeNumber) {
//               winningDetails.add({
//                 "date": date,
//                 "prize": prizeNumber,
//                 "category": prizeCategory
//               });
//             }
//           } else if (prizeCategory == "G7") {
//             if (scannedNumbers.substring(scannedNumbers.length - 2) ==
//                 prizeNumber) {
//               winningDetails.add({
//                 "date": date,
//                 "prize": prizeNumber,
//                 "category": prizeCategory
//               });
//             }
//           }
//         }
//       }
//     }

//     bool isWinningTicket = winningDetails.isNotEmpty;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(isWinningTicket ? "Congratulations!" : "Try Again"),
//           content: isWinningTicket
//               ? Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: winningDetails
//                       .map((detail) => Text(
//                           "Date: ${detail["date"]}, Prize: ${detail["prize"]} (${detail["category"]})"))
//                       .toList(),
//                 )
//               : const Text("Sorry, better luck next time."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchPrizesData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lottery Prizes'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.camera_alt),
//             onPressed: scanTicket,
//           ),
//           IconButton(
//             icon: const Icon(Icons.calendar_today),
//             onPressed: () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: selectedDate,
//                 firstDate: DateTime(2024, 04, 26), // Adjust as needed
//                 lastDate: DateTime.now(),
//               );
//               if (pickedDate != null) {
//                 setState(() {
//                   selectedDate = pickedDate;
//                 });
//                 fetchPrizesData();
//               }
//             },
//           ),
//         ],
//       ),
//       body: prizesData.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: prizesData.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(prizesData[index]["date"] as String),
//                   subtitle:
//                       Text((prizesData[index]["prizes"] as List).join(', ')),
//                 );
//               },
//             ),
//     );
//   }
// }
