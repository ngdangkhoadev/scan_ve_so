import 'package:do_ve_so/component/ItemHome.dart';
import 'package:do_ve_so/mien_bac/mien_bac_screen.dart';
import 'package:do_ve_so/mien_nam/mien_nam_screen.dart';
import 'package:do_ve_so/mien_trung/mien_trung_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KienThietHome extends StatelessWidget {
  const KienThietHome({
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
              offset: const Offset(0, 3), // changes position of shadow
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
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/game.png"))),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Text(
                    "Xổ số kiến thiết",
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
                      child: const ItemHome(
                        image: "assets/images/hanoi.png",
                        textName: "Miền Bắc",

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
                                builder: (context) =>
                                    const MienTrungScreen())); // Chang
                      },
                      child: const ItemHome(
                        image: "assets/images/trung.png",

                        textName: "Miền Trung",

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
                              builder: (context) => const MienNamScreen()),
                        );
                      },
                      child: const ItemHome(
                        image: "assets/images/nam.png",
                        textName: "Miền Nam",
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
