import 'package:dasboard_admin/controllers/ticket_controller.dart';
import 'package:dasboard_admin/widgets/components/button_bottom_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketOverviewScreen extends StatefulWidget {
  const TicketOverviewScreen({super.key});

  @override
  State<TicketOverviewScreen> createState() => _TicketOverviewScreenState();
}

class _TicketOverviewScreenState extends State<TicketOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cu = Get.put(TicketController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
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
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: 'Search by name',
                      ),
                      onChanged: (value) {},
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
                          itemBuilder: (context, index) => ListTile(
                            leading: Text(
                                cu.ticketList.value[index].ticket?.IdTicket ??
                                    "No ID"),
                            title: Text(cu
                                    .ticketList.value[index].ticket?.CreateAt
                                    .toString() ??
                                "No Name"),
                            subtitle: Text(cu.ticketList.value[index].ticket
                                    ?.DurationActive
                                    .toString() ??
                                ""),
                          ),
                          // ignore: invalid_use_of_protected_member
                          itemCount: cu.ticketList.value.length,
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
        )),
      ),
    );
  }
}
