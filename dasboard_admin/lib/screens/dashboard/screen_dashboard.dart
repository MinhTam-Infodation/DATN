import 'package:dasboard_admin/controllers/ticket_controller.dart';
import 'package:dasboard_admin/controllers/total_controller.dart';
import 'package:dasboard_admin/screens/manager_ticket/screen_ticket_overview.dart';
import 'package:dasboard_admin/screens/manager_user/screen_user_overview.dart';
import 'package:dasboard_admin/screens/users/screen_user_settings.dart';
import 'package:dasboard_admin/ulti/styles/main_styles.dart';
import 'package:dasboard_admin/widgets/components/bottom_bar.dart';
import 'package:dasboard_admin/widgets/components/card_custom.dart';
import 'package:dasboard_admin/widgets/components/list_tile_custom.dart';
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

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    //final cu = Get.find<TotalController>(tag: "dsuser");
    // ignore: unused_local_variable
    final cu = Get.put(TotalController());
    final ti = Get.put(TicketController());

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
                          height: 24,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 100,
                            child: Text(
                              "Sumary",
                              style: titleHeader,
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
                              () => CardCustom(
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
                            )
                          ],
                        ),
                        Row(
                          children: [
                            GetBuilder<TicketController>(
                              init: TicketController(),
                              builder: (s) => GestureDetector(
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
                                    subTitle: s
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
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          // ignore: sized_box_for_whitespace
                          child: Container(
                            width: 100,
                            child: Text(
                              "Caculator",
                              style: titleHeader,
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
                                            shape: BoxShape.circle,
                                            color: green),
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
                                // Bar Cusstom
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
}
