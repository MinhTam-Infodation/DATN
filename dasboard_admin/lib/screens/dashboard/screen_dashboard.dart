import 'package:dasboard_admin/controllers/total_controller.dart';
import 'package:dasboard_admin/screens/manager_user/screen_user_overview.dart';
import 'package:dasboard_admin/ulti/styles/main_styles.dart';
import 'package:dasboard_admin/widgets/components/card_custom.dart';
import 'package:dasboard_admin/widgets/components/list_tile_custom.dart';
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

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    // final c = Get.find<TotalController>(tag: "dsuser");
    // ignore: unused_local_variable
    final cu = Get.put(TotalController());

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 100,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 5, color: Colors.blueGrey))),
                          child: const Text(
                            "SUMARY",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () => {Get.to(const UserOverviewScreen())},
                              child: CardCustom(
                                width: size.width / 2 - 23,
                                height: 88.9,
                                mLeft: 0,
                                mRight: 3,
                                child: ListTileCustom(
                                  bgColor: purpleLight,
                                  pathIcon: "line.svg",
                                  title: "ALL USER",
                                  subTitle:
                                      cu.countMyDocuments(cu.list!).toString(),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => CardCustom(
                              width: size.width / 2 - 23,
                              height: 88.9,
                              mLeft: 3,
                              mRight: 0,
                              child: ListTileCustom(
                                bgColor: greenLight,
                                pathIcon: "thumb_up.svg",
                                title: "USER WALTING",
                                subTitle: cu.countAdults(false).toString(),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CardCustom(
                            width: size.width / 2 - 23,
                            height: 88.9,
                            mLeft: 0,
                            mRight: 3,
                            child: ListTileCustom(
                              bgColor: yellowLight,
                              pathIcon: "starts.svg",
                              title: "USER DELAY",
                              subTitle: "855",
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
                              title: "MANAGER",
                              subTitle: "5,436",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 140,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 5, color: Colors.blueGrey))),
                          child: const Text(
                            "CACULATOR",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CardCustom(
                          mLeft: 0,
                          mRight: 0,
                          width: size.width - 40,
                          height: 211,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 9.71,
                                      height: 9.71,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: purple2),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "All User",
                                      style: label,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: 9.71,
                                      height: 9.71,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: green),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "User Walting",
                                      style: label,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: 9.71,
                                      height: 9.71,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: red),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "Conversions",
                                      style: label,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: BarChart(
                                  BarChartData(
                                    maxY: 20,
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.grey,
                                        getTooltipItem: (a, b, c, d) => null,
                                      ),
                                      touchCallback:
                                          (FlTouchEvent event, response) {
                                        if (response == null ||
                                            response.spot == null) {
                                          setState(() {
                                            touchedGroupIndex = -1;
                                            showingBarGroups =
                                                List.of(rawBarGroups);
                                          });
                                          return;
                                        }

                                        touchedGroupIndex =
                                            response.spot!.touchedBarGroupIndex;

                                        setState(() {
                                          if (!event
                                              .isInterestedForInteractions) {
                                            touchedGroupIndex = -1;
                                            showingBarGroups =
                                                List.of(rawBarGroups);
                                            return;
                                          }
                                          showingBarGroups =
                                              List.of(rawBarGroups);
                                          if (touchedGroupIndex != -1) {
                                            var sum = 0.0;
                                            for (final rod in showingBarGroups[
                                                    touchedGroupIndex]
                                                .barRods) {
                                              sum += rod.toY;
                                            }
                                            final avg = sum /
                                                showingBarGroups[
                                                        touchedGroupIndex]
                                                    .barRods
                                                    .length;

                                            showingBarGroups[
                                                    touchedGroupIndex] =
                                                showingBarGroups[
                                                        touchedGroupIndex]
                                                    .copyWith(
                                              barRods: showingBarGroups[
                                                      touchedGroupIndex]
                                                  .barRods
                                                  .map((rod) {
                                                return rod.copyWith(
                                                    toY: avg,
                                                    color: Colors.redAccent);
                                              }).toList(),
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: bottomTitles,
                                          reservedSize: 42,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 28,
                                          interval: 1,
                                          getTitlesWidget: leftTitles,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    barGroups: showingBarGroups,
                                    gridData: FlGridData(show: false),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset("assets/icons/home.svg"),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset("assets/icons/chart.svg"),
              ),
              label: "Chart",
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset("assets/icons/profile.svg"),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 0) {
    text = '1K';
  } else if (value == 10) {
    text = '5K';
  } else if (value == 19) {
    text = '10K';
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
  final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

  final Widget text = Text(
    titles[value.toInt()],
    style: const TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16, //margin top
    child: text,
  );
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(
    barsSpace: 4,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: Colors.red,
        width: 10,
      ),
      BarChartRodData(
        toY: y2,
        color: Colors.blueAccent,
        width: 10,
      ),
    ],
  );
}

Widget makeTransactionsIcon() {
  const width = 4.5;
  const space = 3.5;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: width,
        height: 10,
        color: Colors.white.withOpacity(0.4),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 28,
        color: Colors.white.withOpacity(0.8),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 42,
        color: Colors.white.withOpacity(1),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 28,
        color: Colors.white.withOpacity(0.8),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 10,
        color: Colors.white.withOpacity(0.4),
      ),
    ],
  );
}
