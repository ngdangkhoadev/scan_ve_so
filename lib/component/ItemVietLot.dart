import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemvietLot extends StatefulWidget {
  final String textName;
  final String image;
  const ItemvietLot({
    super.key,
    required this.textName,
    required this.image,
  });

  @override
  State<ItemvietLot> createState() => _ItemvietLotState();
}

class _ItemvietLotState extends State<ItemvietLot> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(10.r)),
            child: Padding(
              padding: REdgeInsets.all(15.sp),
              child: Container(
                  height: 40.h,
                  width: 40.w,
                  child: Image(image: AssetImage(widget.image))),
            ),
          ),
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
    );
  }
}
