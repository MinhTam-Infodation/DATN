import 'package:dasboard_admin/controllers/waltinguser_controller.dart';
import 'package:dasboard_admin/ulti/styles/main_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ScreenUserWalting extends StatefulWidget {
  const ScreenUserWalting({super.key});

  @override
  State<ScreenUserWalting> createState() => _ScreenUserWaltingState();
}

class _ScreenUserWaltingState extends State<ScreenUserWalting> {
  final cu = Get.put(WaltingUserController());

  final TextEditingController _searchController = TextEditingController();
  bool _isClearVisible = false;
  bool isChecked = false;

  void _onSearchTextChanged(String value) {
    setState(() {
      _isClearVisible = value.isNotEmpty;
    });

    if (value.isNotEmpty) {
      cu.searchUser(value);
    } else {
      cu.getListUser();
    }
  }

  void _onClearPressed() {
    setState(() {
      _searchController.clear();
      _isClearVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // cu.getUsersStatus(false);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text(
            "Manager Walting",
            style: textAppKanit,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt),
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      top: 2, bottom: 2, right: 10, left: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchTextChanged,
                          decoration: const InputDecoration(
                              hintText: 'Search...', border: InputBorder.none),
                        ),
                      ),
                      Visibility(
                        visible: _isClearVisible,
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _onClearPressed,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: size.height - 200,
                      width: size.width - 40,
                      child: Obx(
                        () {
                          return ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GFCheckboxListTile(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              color: Colors.white,
                              customBgColor: Colors.white,
                              activeBorderColor: Colors.white,
                              inactiveBgColor: Colors.white,
                              titleText: cu.listUsers[index].user!.Name,
                              subTitleText: cu.listUsers[index].user!.Email,
                              size: 25,
                              activeBgColor: Colors.green,
                              type: GFCheckboxType.circle,
                              activeIcon: const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                              onChanged: (value) {
                                cu.updateUserStatus(
                                    cu.listUsers[index].user!.Id!);
                              },
                              inactiveIcon: null,
                              value: cu.listUsers[index].user!.Status!,
                            ),

                            // ignore: invalid_use_of_protected_member
                            itemCount: cu.listUsers.value.length,
                            padding: const EdgeInsets.only(bottom: 50 + 16),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 0),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
