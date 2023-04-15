import 'package:dasboard_admin/controllers/total_controller.dart';
import 'package:dasboard_admin/widgets/components/button_bottom_custom.dart';
import 'package:dasboard_admin/widgets/components/cart_item_user.dart';
import 'package:dasboard_admin/widgets/components/modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOverviewScreen extends StatefulWidget {
  const UserOverviewScreen({super.key});

  @override
  State<UserOverviewScreen> createState() => _UserOverviewScreenState();
}

class _UserOverviewScreenState extends State<UserOverviewScreen> {
  // ignore: unused_field
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController txtSearch = TextEditingController();
  final cu = Get.put(TotalController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: txtSearch,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            hintText: 'Search by name',
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // cu.searchUsersByName(value);
                              cu.searchUsers([
                                {'field': 'Name', 'value': value}
                              ]);
                            } else {
                              cu.getSinhviens();
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.list,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: size.height - 150,
                        width: size.width - 40,
                        child: Obx(
                          () {
                            return ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  CartItemUser(user: cu.users[index].user!),
                              // ignore: invalid_use_of_protected_member
                              itemCount: cu.users.value.length,
                              padding: const EdgeInsets.only(bottom: 50 + 16),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 0),
                            );
                          },
                        ),
                      ),
                      const ButtonBottomCustom(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
