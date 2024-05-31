import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemHome extends StatefulWidget {
  final String textName;
  final String image;
  const ItemHome({
    super.key,
    required this.textName,
    required this.image,
  });

  @override
  State<ItemHome> createState() => _ItemHomeState();
}

class _ItemHomeState extends State<ItemHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 80.h,
                width: 80.w,
                child: Image(image: AssetImage(widget.image))),
            SizedBox(
              height: 10.h,
            ),
            FittedBox(
              child: Text(
                maxLines: 1,
                widget.textName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
