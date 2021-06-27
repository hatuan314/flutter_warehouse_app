import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class ContactTypeWidget extends StatelessWidget {
  final String title;
  final List<String> contactList;

  const ContactTypeWidget(
      {Key key, @required this.title, @required this.contactList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingHorizontalApp,
          vertical: LayoutConstants.paddingVertical20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ThemeText.subtitle1,
          ),
          Column(
              children: contactList.map((contact) {
            if (contact.isSafe) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    contact,
                    style: ThemeText.caption,
                  ),
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: LayoutConstants.paddingHorizontalApp,
                          vertical: LayoutConstants.paddingVertical10),
                      child: Text(
                        StringConstants.changeTxt,
                        style: ThemeText.caption
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              );
            }
            return SizedBox();
          }).toList())
        ],
      ),
    );
  }
}
