import 'package:flutter/material.dart';

class LotteryNumberRow extends StatelessWidget {
  final String title;
  final List<String> numbers;

  LotteryNumberRow(this.title, this.numbers);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0,
              children: numbers
                  .map((number) => Text(
                        number,
                        style: TextStyle(fontSize: 18),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
