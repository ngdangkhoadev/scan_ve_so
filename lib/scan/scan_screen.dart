import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  final File imageFile;
  const ScanScreen({super.key, required this.imageFile});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 7,
              child: Center(child: Image.file(widget.imageFile)),
            ),
            Flexible(
                flex: 3,
                child: SingleChildScrollView(
                    child: Center(child: _extractTextView()))),
            // Expanded(
            //   flex: 2,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       GestureDetector(
            //         onTap: () async {
            //           List<MediaFile>? media = await GalleryPicker.pickMedia(
            //               context: context, singleMedia: true);
            //           if (media != null && media.isNotEmpty) {
            //             var data = await media.first.getFile();
            //             setState(() {
            //               selectedMedia = data;
            //             });
            //           }
            //         },
            //         child: Container(
            //           height: 100,
            //           width: 100,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.5),
            //                 spreadRadius: 5,
            //                 blurRadius: 7,
            //                 offset: const Offset(
            //                     0, 3), // changes position of shadow
            //               ),
            //             ],
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Container(
            //                 height: 50.h,
            //                 width: 50.w,
            //                 decoration: const BoxDecoration(
            //                     image: DecorationImage(
            //                         image:
            //                             AssetImage("assets/images/photo.png"))),
            //               ),
            //               const Text("Thư viện")
            //             ],
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         // onTap: () {
            //         // getImage();
            //         // },
            //         onTap: onPressed,
            //         child: Container(
            //           height: 100,
            //           width: 100,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.5),
            //                 spreadRadius: 5,
            //                 blurRadius: 7,
            //                 offset: const Offset(
            //                     0, 3), // changes position of shadow
            //               ),
            //             ],
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Container(
            //                 height: 50.h,
            //                 width: 50.w,
            //                 decoration: const BoxDecoration(
            //                     image: DecorationImage(
            //                         image: AssetImage(
            //                             "assets/images/pick_photo.png"))),
            //               ),
            //               const Text("Máy ảnh")
            //             ],
            //           ),
            //         ),
            //       ),
            //       // for (var picture in _pictures) Image.file(File(picture))
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _extractTextView() {
    return FutureBuilder(
        future: _extractText(widget.imageFile),
        builder: (context, snapshot) {
          return Text(snapshot.data ?? "");
        });
  }

  Future<String?> _extractText(File file) async {
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    return text;
  }
}
