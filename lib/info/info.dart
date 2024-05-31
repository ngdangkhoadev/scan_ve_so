import 'package:do_ve_so/info/bloc/bloc/setting_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc(),
      child: const SettingView(),
    );
  }
}

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  // bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          "Cài Đặt",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.amber[50],
        child: Padding(
          padding: REdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nhận thông báo miền Bắc",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        buildWhen: (pre, current) =>
                            pre.isSwitchedBac != current.isSwitchedBac,
                        builder: (context, state) {
                          return Switch(
                            thumbIcon: thumbIcon,
                            autofocus: false,
                            activeTrackColor: Colors.amber,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[350],
                            activeColor: Colors.white,
                            // value: isSwitched,
                            onChanged: ((value) {
                              context
                                  .read<SettingBloc>()
                                  .add(const NotificationMienBac());
                            }),
                            value: state.isSwitchedBac,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nhận thông báo miền Trung",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        buildWhen: (pre, current) =>
                            pre.isSwitchedTrung != current.isSwitchedTrung,
                        builder: (context, state) {
                          return Switch(
                            thumbIcon: thumbIcon,
                            autofocus: false,
                            activeTrackColor: Colors.amber,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[350],
                            activeColor: Colors.white,
                            // value: isSwitched,
                            onChanged: ((value) {
                              context
                                  .read<SettingBloc>()
                                  .add(const NotificationMienTrung());
                            }),
                            value: state.isSwitchedTrung,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nhận thông báo miền Nam",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        buildWhen: (pre, current) =>
                            pre.isSwitchedNam != current.isSwitchedNam,
                        builder: (context, state) {
                          return Switch(
                            thumbIcon: thumbIcon,
                            autofocus: false,
                            activeTrackColor: Colors.amber,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[350],
                            activeColor: Colors.white,
                            // value: isSwitched,
                            onChanged: ((value) {
                              context
                                  .read<SettingBloc>()
                                  .add(const NotificationMienNam());
                            }),
                            value: state.isSwitchedNam,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nhận thông báo xổ số Mega",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        buildWhen: (pre, current) =>
                            pre.isSwitchedMega != current.isSwitchedMega,
                        builder: (context, state) {
                          return Switch(
                            thumbIcon: thumbIcon,
                            autofocus: false,
                            activeTrackColor: Colors.amber,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[350],
                            activeColor: Colors.white,
                            // value: isSwitched,
                            onChanged: ((value) {
                              context
                                  .read<SettingBloc>()
                                  .add(const NotificationMega());
                            }),
                            value: state.isSwitchedMega,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nhận thông báo xổ số Power",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        buildWhen: (pre, current) =>
                            pre.isSwitchedPower != current.isSwitchedPower,
                        builder: (context, state) {
                          return Switch(
                            thumbIcon: thumbIcon,
                            autofocus: false,
                            activeTrackColor: Colors.amber,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[350],
                            activeColor: Colors.white,
                            // value: isSwitched,
                            onChanged: ((value) {
                              context
                                  .read<SettingBloc>()
                                  .add(const NotificationPower());
                            }),
                            value: state.isSwitchedPower,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nhận thông báo xổ số Keno",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        buildWhen: (pre, current) =>
                            pre.isSwitchedKeno != current.isSwitchedKeno,
                        builder: (context, state) {
                          return Switch(
                            thumbIcon: thumbIcon,
                            autofocus: false,
                            activeTrackColor: Colors.amber,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[350],
                            activeColor: Colors.white,
                            // value: isSwitched,
                            onChanged: ((value) {
                              context
                                  .read<SettingBloc>()
                                  .add(const NotificationKeno());
                            }),
                            value: state.isSwitchedKeno,
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
