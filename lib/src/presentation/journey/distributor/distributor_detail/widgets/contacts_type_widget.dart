import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class ContactTypeWidget extends StatelessWidget {
  final String title;
  final List<String> contactList;
  final Function(String) onChanged;

  const ContactTypeWidget(
      {Key key,
      @required this.title,
      @required this.contactList,
      @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contactList.isSafe) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingHorizontalApp,
        ).copyWith(
          bottom: LayoutConstants.paddingVertical10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                    Expanded(
                      child: Text(
                        contact,
                        style: ThemeText.body2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ConnectivityUtils.checkConnectInternet().then((value) {
                          if (value) {
                            onChanged(contact);
                          } else {
                            locator<SnackbarBloc>().add(ShowSnackbar(
                              title: StringConstants.noInternetTxt,
                              type: SnackBarType.disconnect,
                            ));
                          }
                        });
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                                vertical: LayoutConstants.paddingVertical10)
                            .copyWith(
                                left: LayoutConstants.paddingHorizontalApp),
                        child: Text(
                          StringConstants.changeTxt,
                          style: ThemeText.body2
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                );
              }
              return SizedBox();
            }).toList()),
            Divider(
              height: 10,
              thickness: 1,
              color: AppColor.lineColor,
            )
          ],
        ),
      );
    }
    return SizedBox();
  }
}
