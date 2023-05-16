import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:dasboard_admin/controllers/ticket_controller.dart';
import 'package:dasboard_admin/controllers/total_controller.dart';
import 'package:dasboard_admin/controllers/waltinguser_controller.dart';
import 'package:dasboard_admin/screens/dashboard/components/indicator.dart';
import 'package:dasboard_admin/screens/manager_ticket/screen_ticket_overview.dart';
import 'package:dasboard_admin/screens/manager_user/manager_walting/screen_user_wailting.dart';
import 'package:dasboard_admin/screens/manager_user/screen_user_overview.dart';
import 'package:dasboard_admin/ulti/styles/main_styles.dart';
import 'package:dasboard_admin/widgets/components/card_custom.dart';
import 'package:dasboard_admin/widgets/components/list_tile_custom.dart';
import 'package:dasboard_admin/widgets/coupon_card/horizontal_cupon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  late double width = 7;
  int touchedIndex = -1;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late int showingTooltip = -1;

  int _currentIndex = 0;
  int touchedGroupIndex = -1;

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(toY: y.toDouble()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //final cu = Get.find<TotalController>(tag: "dsuser");
    // ignore: unused_local_variable
    final cu = Get.put(TotalController());
    final ti = Get.put(TicketController());

    final wail = Get.put(WaltingUserController());
    wail.countMyDocuments();
    wail.countMyDocumentsWithStatusFalse();
    wail.countMyDocumentsWithStatusTrue();
    wail.countNewUsers();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _bottomNavBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 6,
                  color: sparatorColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hello ${FirebaseAuth.instance.currentUser?.email}",
                              style: headerUser,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/notifications.svg',
                                // ignore: deprecated_member_use
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sumary",
                            style: textBigKanit,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () =>
                                    {Get.to(() => const UserOverviewScreen())},
                                child: CardCustom(
                                  width: size.width / 2 - 23,
                                  height: 88.9,
                                  mLeft: 0,
                                  mRight: 3,
                                  child: ListTileCustom(
                                    bgColor: purpleLight,
                                    pathIcon: "line.svg",
                                    title: "ALL USER",
                                    subTitle: cu
                                        .countMyDocuments(cu.users)
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => GestureDetector(
                                onTap: () =>
                                    {Get.to(() => const ScreenUserWalting())},
                                child: CardCustom(
                                  width: size.width / 2 - 23,
                                  height: 88.9,
                                  mLeft: 3,
                                  mRight: 0,
                                  child: ListTileCustom(
                                    bgColor: greenLight,
                                    pathIcon: "thumb_up.svg",
                                    title: "WALTING",
                                    subTitle: cu.countAdults(false).toString(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () => {
                                  Get.to(() => const TicketOverviewScreen())
                                },
                                child: CardCustom(
                                  width: size.width / 2 - 23,
                                  height: 88.9,
                                  mLeft: 0,
                                  mRight: 3,
                                  child: ListTileCustom(
                                    bgColor: yellowLight,
                                    pathIcon: "starts.svg",
                                    title: "TICKET",
                                    subTitle: ti
                                        .countMyDocuments(ti.ticketList)
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                            CardCustom(
                              width: size.width / 2 - 23,
                              height: 88.9,
                              mLeft: 3,
                              mRight: 0,
                              child: ListTileCustom(
                                bgColor: blueLight,
                                pathIcon: "eyes.svg",
                                title: "REPORT",
                                subTitle: "1",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          // ignore: sized_box_for_whitespace
                          child: Text(
                            "Overview",
                            style: textBigKanit,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CardCustom(
                            mLeft: 0,
                            mRight: 0,
                            width: size.width - 40,
                            height: 235,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Indicator(
                                        color: Colors.greenAccent,
                                        text: 'Active',
                                        isSquare: false,
                                        size: touchedIndex == 0 ? 14 : 12,
                                        textColor: touchedIndex == 0
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                      Indicator(
                                        color: Colors.blueAccent,
                                        text: 'Walting',
                                        isSquare: false,
                                        size: touchedIndex == 1 ? 14 : 12,
                                        textColor: touchedIndex == 1
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                // Bar Cusstom
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: Obx(() => PieChart(
                                        PieChartData(
                                          pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {
                                              setState(() {
                                                if (!event
                                                        .isInterestedForInteractions ||
                                                    pieTouchResponse == null ||
                                                    pieTouchResponse
                                                            .touchedSection ==
                                                        null) {
                                                  touchedIndex = -1;
                                                  return;
                                                }
                                                touchedIndex = pieTouchResponse
                                                    .touchedSection!
                                                    .touchedSectionIndex;
                                              });
                                            },
                                          ),
                                          startDegreeOffset: 180,
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 10,
                                          centerSpaceRadius: 0,
                                          sections: showingSections(),
                                        ),
                                        swapAnimationDuration: const Duration(
                                            milliseconds: 150), // Optional
                                        swapAnimationCurve:
                                            Curves.linear, // Optional
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        CardCustom(
                            mLeft: 0,
                            mRight: 0,
                            width: size.width - 40,
                            height: 235,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Indicator(
                                        color: Colors.blueAccent,
                                        text: 'Total',
                                        isSquare: false,
                                        size: touchedIndex == 1 ? 14 : 12,
                                        textColor: touchedIndex == 1
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                // Bar Cusstom
                                SizedBox(
                                  width: 340,
                                  height: 150,
                                  child: AspectRatio(
                                      aspectRatio: 2,
                                      child: Obx(
                                        () => BarChart(BarChartData(
                                            barGroups: [
                                              generateGroupData(
                                                  1,
                                                  wail.userCountByMonth[1]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  2,
                                                  wail.userCountByMonth[2]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  3,
                                                  wail.userCountByMonth[3]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  4,
                                                  wail.userCountByMonth[4]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  5,
                                                  wail.userCountByMonth[5]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  6,
                                                  wail.userCountByMonth[6]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  7,
                                                  wail.userCountByMonth[7]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  8,
                                                  wail.userCountByMonth[8]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  9,
                                                  wail.userCountByMonth[9]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  10,
                                                  wail.userCountByMonth[10]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  11,
                                                  wail.userCountByMonth[11]
                                                          ?.value ??
                                                      0),
                                              generateGroupData(
                                                  12,
                                                  wail.userCountByMonth[12]
                                                          ?.value ??
                                                      0),
                                            ],
                                            barTouchData: BarTouchData(
                                                enabled: true,
                                                handleBuiltInTouches: false,
                                                touchCallback:
                                                    (event, response) {
                                                  if (response != null &&
                                                      response.spot != null &&
                                                      event is FlTapUpEvent) {
                                                    setState(() {
                                                      final x = response.spot!
                                                          .touchedBarGroup.x;
                                                      final isShowing =
                                                          showingTooltip == x;
                                                      if (isShowing) {
                                                        showingTooltip = -1;
                                                      } else {
                                                        showingTooltip = x;
                                                      }
                                                    });
                                                  }
                                                },
                                                mouseCursorResolver:
                                                    (event, response) {
                                                  return response == null ||
                                                          response.spot == null
                                                      ? MouseCursor.defer
                                                      : SystemMouseCursors
                                                          .click;
                                                }))),
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //* Item
  static const List<TabItem> items = [
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.chat,
      title: 'Chat',
    ),
    TabItem(
      icon: Icons.person,
      title: 'User',
    ),
  ];

  //* Define Panigator
  Widget _bottomNavBar() => Container(
        margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        child: BottomBarFloating(
          items: items,
          borderRadius: BorderRadius.circular(50),
          backgroundColor: Colors.white,
          color: Colors.black,
          colorSelected: Colors.red,
          indexSelected: _currentIndex,
          onTap: (int index) => setState(() {
            _currentIndex = index;
          }),
        ),
      );
  //* Pie Data
  List<PieChartSectionData> showingSections() {
    final wail = Get.put(WaltingUserController());
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = Colors.greenAccent;
        const color1 = Colors.blueAccent;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: double.parse(wail.totalActive.value.toString()),
              title:
                  '${((double.parse(wail.totalActive.value.toString()) / double.parse(wail.totalAll.value.toString())) * 100).round()} %',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: double.parse(wail.totalWalting.value.toString()),
              title:
                  '${((double.parse(wail.totalWalting.value.toString()) / double.parse(wail.totalAll.value.toString())) * 100).round()} %',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
