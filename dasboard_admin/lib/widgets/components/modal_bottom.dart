// ignore: must_be_immutable
import 'package:dasboard_admin/modals/users_modal.dart';
import 'package:dasboard_admin/ulti/styles/main_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomModalBottomUser extends StatefulWidget {
  CustomModalBottomUser(
      {super.key, required this.user, required this.tranform});

  User user;
  bool tranform;

  @override
  State<CustomModalBottomUser> createState() => _CustomModalBottomUserState();
}

class _CustomModalBottomUserState extends State<CustomModalBottomUser> {
  late TextEditingController txtName;
  late TextEditingController txtAddress;
  late TextEditingController txtEmail;
  late TextEditingController txtPhone;
  late TextEditingController txtActiveDate;
  late TextEditingController txtCreateDate;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtAddress = TextEditingController();
    txtEmail = TextEditingController();
    txtPhone = TextEditingController();
    txtActiveDate = TextEditingController();
    txtCreateDate = TextEditingController();

    DateTime tsdate =
        DateTime.fromMillisecondsSinceEpoch(widget.user.ActiveAt!);
    String datetime = "${tsdate.year}/${tsdate.month}/${tsdate.day}";

    DateTime tsdatecreate =
        DateTime.fromMillisecondsSinceEpoch(widget.user.CreateAt!);
    String datecreate =
        "${tsdatecreate.year}/${tsdatecreate.month}/${tsdatecreate.day}";

    txtName.text = widget.user.Name!;
    txtAddress.text = widget.user.Address!;
    txtEmail.text = widget.user.Email!;
    txtPhone.text = widget.user.Phone!;
    txtActiveDate.text = datetime;
    txtCreateDate.text = datecreate;
  }

  @override
  void dispose() {
    txtName.dispose();
    txtAddress.dispose();
    txtEmail.dispose();
    txtPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            child: Text(
                              widget.tranform ? "Edit" : "Detail",
                              style: textMonster,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          widget.tranform ? Icons.edit : Icons.reorder_sharp,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        weight: 900,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 130,
                height: 130,
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
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      // ignore: invalid_use_of_protected_member
                      widget.user.Avatar ?? ''),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: widget.tranform,
                controller: txtPhone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                enabled: widget.tranform,
                controller:
                    txtActiveDate, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Active Date" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      txtActiveDate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                enabled: widget.tranform,
                controller:
                    txtCreateDate, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Create Date" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      txtCreateDate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              if (widget.tranform)
                ElevatedButton(onPressed: () {}, child: const Text("Helllo"))
              else
                const SizedBox(
                  height: 20,
                )
            ],
          ),
        ),
      ),
    );
  }
}
