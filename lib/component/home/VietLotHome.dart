import 'package:do_ve_so/component/ItemHome.dart';
import 'package:do_ve_so/component/ItemVietLot.dart';
import 'package:do_ve_so/mien_bac/mien_bac_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VietLotHome extends StatelessWidget {
  const VietLotHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/logovietlot.png"))),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Xổ số điện toán",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MienBacScreen()),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: const ItemvietLot(
                            image: "assets/images/645rmv.png",
                            textName: "Mega",

                            // colorBGIc: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MienBacScreen())); // Chang
                      },
                      child: const ItemvietLot(
                        image: "assets/images/logovietlot.png",

                        textName: "Power",

                        // colorBGIc: Colors.purple,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MienBacScreen()),
                        );
                      },
                      child: ItemvietLot(
                        image: "assets/images/kenormv.png",
                        textName: "Keno",
                        // colorBGIc: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MienBacScreen()),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: const ItemvietLot(
                            image: "assets/images/645rmv.png",
                            textName: "Mega",

                            // colorBGIc: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MienBacScreen())); // Chang
                      },
                      child: const ItemvietLot(
                        image: "assets/images/logovietlot.png",

                        textName: "Power",

                        // colorBGIc: Colors.purple,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MienBacScreen()),
                        );
                      },
                      child: ItemvietLot(
                        image: "assets/images/kenormv.png",
                        textName: "Keno",
                        // colorBGIc: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
