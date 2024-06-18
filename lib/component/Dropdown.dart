import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final void Function(String?) onChanged;
  final String hintText;

  CustomDropdownWidget({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(width: 0.7.w, color: Colors.grey.shade500),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(width: 0.7.w, color: Colors.grey.shade500),
        ),
        hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
        contentPadding: REdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          hint: selectedValue == null
              ? Text(
                  hintText,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                )
              : Text(selectedValue!),
        ),
      ),
    );
  }
}
