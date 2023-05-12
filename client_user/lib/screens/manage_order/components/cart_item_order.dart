import 'package:client_user/modal/products.dart';
import 'package:client_user/uilt/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItemOrder extends StatefulWidget {
  const CartItemOrder({super.key, required this.product});

  final Products product;

  @override
  State<CartItemOrder> createState() => _CartItemOrderState();
}

class _CartItemOrderState extends State<CartItemOrder> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            foregroundColor: Colors.black,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        // ignore: invalid_use_of_protected_member
                        "${widget.product.Name} ",
                        style: textNormalKanitBold),
                    const SizedBox(height: 10),
                    Wrap(
                      children: [
                        Text(
                          // ignore: invalid_use_of_protected_member
                          "Slot: ${widget.product.Price.toString()}",
                          style: textNormalQuicksanBold,
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
}
