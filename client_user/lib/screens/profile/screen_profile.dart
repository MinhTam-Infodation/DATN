import 'package:client_user/constants/const_spacer.dart';
import 'package:client_user/constants/string_button.dart';
import 'package:client_user/constants/string_context.dart';
import 'package:client_user/repository/auth_repository/auth_repository.dart';
import 'package:client_user/screens/profile/components/update_profile.dart';
import 'package:client_user/uilt/style/color/color_main.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text(
            tProfileTitle,
            style: textAppKanit,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(controller.user.value.Avatar!)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: padua),
                        child: Icon(
                          Icons.edit,
                          color: bgBlack,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  controller.user.value.Email!,
                  style: textAppKanit,
                ),
                Text(
                  controller.user.value.Name!,
                  style: textXLQuicksan,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const StadiumBorder(),
                          foregroundColor: bgBlack,
                          backgroundColor: padua,
                          padding: const EdgeInsets.symmetric(
                              vertical: sButtonHeight)),
                      onPressed: () =>
                          Get.to(() => const ScreenUpdateProfile()),
                      child: Text(
                        tButtonProfile,
                        style: textXLQuicksanBold,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: 'Setting',
                  icon: Icons.settings,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: "BillDetail",
                  icon: Icons.wallet,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: "UserManager",
                  icon: Icons.person,
                  onPress: () {},
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: "Infomation",
                  icon: Icons.info,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: "LogOut",
                  icon: Icons.logout,
                  onPress: () {},
                  textColor: Colors.redAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool? endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: padua.withOpacity(0.5)),
        child: Icon(
          icon,
          color: bgBlack,
        ),
      ),
      title: Text(
        title,
        style: textNormalKanit.apply(color: textColor),
      ),
      trailing: endIcon!
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green.withOpacity(0.1)),
              child: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 30,
              ),
            )
          : null,
    );
  }
}