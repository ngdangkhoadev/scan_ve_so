import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MegaScreen extends StatelessWidget {
  MegaScreen({super.key});

  List XoSo = [
    [
      '02',
      'Trip',
    ],
    [
      'assets/images/services/rentals.png',
      'Rentals',
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: ListView.builder(
          itemCount: XoSo.length,
          itemBuilder: (BuildContext context, int index) {
            return Container();
          },
        ),
      )),
    );
  }
}
