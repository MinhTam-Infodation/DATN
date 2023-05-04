import 'package:client_user/uilt/style/button_style/button_style.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        SizedBox(
          height: 45,
          width: 45,
          child: PrimaryShadowedButton(
            onPressed: () {},
            // ignore: sort_child_properties_last
            child: Center(
              child: Icon(Icons.menu,
                  size: 18, color: Theme.of(context).colorScheme.surface),
            ),
            borderRadius: 12,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
