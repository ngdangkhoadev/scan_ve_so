import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  String hintext;
  DateInputWidget(
      {required this.controller,
      required this.onChanged,
      required this.hintext});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          readOnly: true,
          style: TextStyle(fontSize: 12.sp, color: Colors.black),
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 0.7.w, color: Colors.grey.shade500),
            ),
            suffixIcon: Icon(Icons.calendar_month),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 0.7.w, color: Colors.grey.shade500),
            ),
            hintText: hintext,
            hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
            contentPadding:
                REdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (controller.text.isNotEmpty) {
      final parts = controller.text.split('/');
      if (parts.length == 3) {
        initialDate = DateTime(
            int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      controller.text = formattedDate;
      onChanged(formattedDate);
    }
  }
}
