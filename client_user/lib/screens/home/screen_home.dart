// ignore_for_file: unnecessary_null_comparison
import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/constants/string_img.dart';
import 'package:client_user/controller/home_controller.dart';
import 'package:client_user/controller/manage_table.dart';
import 'package:client_user/repository/auth_repository/auth_repository.dart';
import 'package:client_user/screens/home/components/box_content_manager.dart';
import 'package:client_user/screens/home/components/category_catalog.dart';
import 'package:client_user/screens/home/components/search_bar.dart';
import 'package:client_user/screens/home/drawer/drawer_header.dart';
import 'package:client_user/screens/manage_product/screen_manager_product.dart';
import 'package:client_user/screens/manager_seller/screen_manager_seller.dart';
import 'package:client_user/screens/manager_table/screen_manage_table.dart';
import 'package:client_user/screens/profile/screen_profile.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final List<String> items = List<String>.generate(100, (i) => "Item $i");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final box = GetStorage();
  var userId = "";
  var currentPage = DrawerSections.dashboard;

  final controller = Get.put(AuthenticationRepository());
  final tableController = Get.put(ManageTableController());
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }
    tableController.getListTable(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      userId = "";
    }

    controller.checkData(userId);
    homeController.checkTotalTable(userId);
    homeController.checkTotalSeller(userId);
    homeController.checkTotalProduct(userId);
    // if (homeController.totalTable > 0) {
    //   tableController.getListTable(userId);
    // }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
          title: Text(
            tAppName,
            style: textAppKanit,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: Obx(() {
                  final user = controller.user.value;
                  if (user == null) {
                    return Image.asset(iHomeProfileTemp2);
                  } else if (user.Avatar == null || user.Avatar == "") {
                    return Image.asset(iHomeProfileTemp2);
                  } else {
                    return Image(image: NetworkImage(user.Avatar!));
                  }
                }),
                color: Colors.black,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: SingleChildScrollView(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(
                    user: controller.user.value,
                  ),
                  MyDrawerList()
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(sDashboardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      tHomeTitle + controller.user.value.Email.toString(),
                      style: textXLQuicksan,
                    )),
                Text(
                  tHomeHeading,
                  style: textBigQuicksan,
                ),
                // const SizedBox(
                //   height: sDashboardPadding,
                // ),
                // Container(
                //   decoration: const BoxDecoration(
                //       border: Border(left: BorderSide(width: 4))),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         tHomeSearch,
                //         style: textBigQuicksanGray,
                //       ),
                //       const Icon(
                //         Icons.mic,
                //         size: 25,
                //       )
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: sDashboardPadding,
                ),
                SizedBox(
                  height: 50,
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Obx(() => BoxContentManager(
                              nameManager: "PR",
                              subnameManager: "Product",
                              total: homeController.totalProduct.toInt(),
                              onPressed: () {
                                Get.to(() => const ScreenManagerProduct());
                              },
                            )),
                        Obx(() => BoxContentManager(
                              nameManager: "SE",
                              subnameManager: "Seller",
                              total: homeController.totalSeller.toInt(),
                              onPressed: () {
                                Get.to(() => const ScreenManageSeller());
                              },
                            )),
                        Obx(
                          () => BoxContentManager(
                            nameManager: "TA",
                            subnameManager: "Table",
                            total: homeController.totalTable.toInt(),
                            onPressed: () {
                              Get.to(() => const ScreenManageTable());
                            },
                          ),
                        )
                      ]),
                ),
                const SizedBox(
                  height: sDashboardPadding,
                ),

                // Banner
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: sparatorColor),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(child: Icon(Icons.bookmark)),
                                Flexible(
                                  child: Image.asset(
                                    iHomeContent1,
                                    height: 100,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              tHomeBannerTitle1,
                              style: textXLQuicksanBold,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              tHomeBannerTitle2,
                              style: textNormalQuicksan,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: sDashboardCardPadding,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: sparatorColor),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Flexible(child: Icon(Icons.bookmark)),
                                  Flexible(
                                      child: Image.asset(
                                    iHomeContent1,
                                    height: 80,
                                  ))
                                ],
                              ),
                              Text(
                                tHomeBannerTitle1,
                                style: textXLQuicksanBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                tHomeBannerTitle2,
                                style: textNormalQuicksan,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side:
                                        BorderSide(color: bgBlack, width: 5.0),
                                  ),
                                  foregroundColor: bgBlack,
                                  backgroundColor: bgWhite,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: sButtonHeight)),
                              onPressed: () {
                                controller.logout();
                              },
                              child: Text(
                                tHomeButton,
                                style: textXLQuicksanBold,
                              )),
                        )
                      ],
                    )),
                  ],
                ),

                const SizedBox(
                  height: sDashboardPadding,
                ),

                Text(
                  tHomeTopProduct,
                  style: textBigQuicksan,
                ),
                const SizedBox(
                  height: sDashboardPadding,
                ),
                Obx(() => SizedBox(
                      child: Column(
                        children: [
                          if (homeController.totalTable.toInt() > 0)
                            SizedBox(
                              child: Column(
                                children: [
                                  const SearchBar(),
                                  const CategoriesCatalog(),
                                  const SizedBox(
                                    height: sDashboardPadding,
                                  ),
                                  SizedBox(
                                    height: 500,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Số cột trong lưới
                                        childAspectRatio:
                                            1, // Tỷ lệ khung hình của mỗi phần tử trong lưới
                                        crossAxisSpacing:
                                            10.0, // khoảng cách giữa các phần tử trong cột
                                        mainAxisSpacing: 10.0,
                                      ),
                                      itemCount:
                                          homeController.totalTable.toInt(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: sparatorColor),
                                          padding: const EdgeInsets.all(10),
                                          child: Obx(() => Text(
                                                " ${tableController.users[index].table!.Name!}",
                                                style: textXLQuicksanBold,
                                                overflow: TextOverflow.visible,
                                              )),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        iHomeNoData,
                                        width: 200,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[
                                          200], // màu nền của đoạn văn bản
                                      borderRadius: BorderRadius.circular(
                                          8.0), // bo tròn cạnh của hộp
                                    ),
                                    padding: const EdgeInsets.all(
                                        10.0), // khoảng cách giữa nội dung và cạnh của hộp
                                    child: const Text(
                                      'Currently there is no data about your table. Please make more tables',
                                      style: TextStyle(fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: sDashboardPadding,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => const ScreenManageTable());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: const StadiumBorder(),
                                      foregroundColor: bgBlack,
                                      backgroundColor: padua,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                    ),
                                    child: SizedBox(
                                      width: 250,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Go to add new Tables"
                                              .toUpperCase()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(Icons.arrow_forward_ios)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menuItem(
      int id, IconData icon, String text, bool selected, VoidCallback? fun) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.table;
              Get.to(() => const ScreenManageTable());
            } else if (id == 3) {
              currentPage = DrawerSections.seller;
            } else if (id == 4) {
              currentPage = DrawerSections.product;
              Get.to(() => const ScreenManagerProduct());
            } else if (id == 5) {
              currentPage = DrawerSections.order;
            } else if (id == 6) {
              currentPage = DrawerSections.history;
            } else if (id == 7) {
              currentPage = DrawerSections.profile;
              Get.to(() => const ScreenProfile());
            } else if (id == 8) {
              currentPage = DrawerSections.logout;
              controller.logout();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              )),
              Expanded(
                flex: 3,
                child: Text(
                  text,
                  style: textXLQuicksan,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          menuItem(1, Icons.dashboard_outlined, "Dashboard",
              currentPage == DrawerSections.dashboard ? true : false, () {}),
          menuItem(2, Icons.table_restaurant_rounded, "Table",
              currentPage == DrawerSections.table ? true : false, () {}),
          menuItem(3, Icons.supervised_user_circle_sharp, "Seller",
              currentPage == DrawerSections.seller ? true : false, () {}),
          menuItem(4, Icons.production_quantity_limits, "Product",
              currentPage == DrawerSections.product ? true : false, () {}),
          menuItem(5, Icons.blinds_outlined, "Order",
              currentPage == DrawerSections.order ? true : false, () {}),
          const Divider(
            thickness: 2,
          ),
          menuItem(6, Icons.blinds_closed, "History",
              currentPage == DrawerSections.history ? true : false, () {}),
          menuItem(7, Icons.person_pin_sharp, "Profile",
              currentPage == DrawerSections.profile ? true : false, () {
            Get.to(() => const ScreenProfile());
          }),
          menuItem(8, Icons.logout, "LogOut",
              currentPage == DrawerSections.logout ? true : false, () {}),
        ],
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  table,
  seller,
  product,
  order,
  history,
  profile,
  logout
}
