import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/widgets/contacts_type_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/widgets/info_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

class DistributorDetailScreen extends StatelessWidget {
  final DistributorEntity distributor;

  const DistributorDetailScreen({Key key, @required this.distributor})
      : super(key: key);

  Widget _bodyWidget() {
    return Column(
      children: [
        InfoWidget(
          distributor: distributor,
        ),
        ContactTypeWidget(
          title: StringConstants.phoneNumberTxt,
          contactList: distributor.phones,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.delete, color: AppColor.black,), onPressed: () {}),
        ],
      ),
      body: _bodyWidget(),
    );
  }
}
