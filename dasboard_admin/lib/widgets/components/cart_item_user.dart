// ignore: must_be_immutable
import 'package:dasboard_admin/controllers/total_controller.dart';
import 'package:dasboard_admin/modals/users_modal.dart';
import 'package:dasboard_admin/ulti/styles/main_styles.dart';
import 'package:dasboard_admin/widgets/components/modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CartItemUser extends StatelessWidget {
  CartItemUser({super.key, required this.user, required this.parentContext});
  User user;
  BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final cu = Get.put(TotalController());
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) =>
                    CustomModalBottomUser(user: user, tranform: true),
              );
            },
            backgroundColor: bgColor,
            foregroundColor: Colors.black,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      // endActionPane: ActionPane(
      //   motion: const ScrollMotion(),
      //   dismissible:
      //       DismissiblePane(onDismissed: () => {cu.deleteUser(user.Id!)}),
      //   children: [
      //     SlidableAction(
      //       onPressed: (context) => _dialogBuilder(
      //           parentContext, "Delete", "Are you sure you want to delete?",
      //           () {
      //         cu.deleteUser(user.Id!);
      //       }),
      //       backgroundColor: bgColor,
      //       foregroundColor: Colors.black,
      //       icon: Icons.save,
      //       label: 'Delete',
      //     ),
      //   ],
      // ),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            isScrollControlled: true,
            context: context,
            builder: (context) =>
                CustomModalBottomUser(user: user, tranform: false),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(
                      2), // thêm khoảng cách giữa viền và CircleAvatar
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.greenAccent.withOpacity(0.5),
                    ),
                  ),
                ),
                // ClipOval(
                //     child: user.Avatar != null && user.Avatar != ""
                //         ? Image.network(
                //             user.Avatar!,
                //             fit: BoxFit.cover,
                //           )
                //         : Container(
                //             color: Colors.greenAccent.withOpacity(0.5),
                //           ),
                //   ),
                // )
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // ignore: invalid_use_of_protected_member
                      user.Name ?? '',
                      style: textXLQuicksanBold,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: [
                        SizedBox(
                          width: 170,
                          child: Text(
                            // ignore: invalid_use_of_protected_member
                            user.Email ?? '',
                            style: textNormalQuicksan,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // ignore: invalid_use_of_protected_member
                        if (user.Status == true)
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Active',
                              style: cartTag,
                            ),
                          )
                        else
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Wailting',
                              style: cartTag,
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _dialogBuilder(BuildContext context, String title,
      String description, VoidCallback outFunction) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Done'),
              onPressed: () {
                outFunction();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _modalBuilder(BuildContext context, bool isEdit, User data) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? 'Edit data' : 'View data',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: data.Name),
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: TextEditingController(text: data.Email),
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  child: Text(isEdit ? 'Save' : 'OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
