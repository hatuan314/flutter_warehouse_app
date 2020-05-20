import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/ui/widgets/base_app_bar_widget.dart';

import 'distributors_list_item_widget.dart';

class ShowAllDistributorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      appBar: _mAppBar(),
      body: _mBody(context),
    );
  }

  Widget _mAppBar() {
    return BaseAppBarWidget(
      title: 'Nhà phân phối',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: Colors.white, size: 24),
        ),
        IconButton(
          icon: Icon(Icons.sort, color: Colors.white, size: 24),
        ),
        IconButton(
          icon: Icon(Icons.add, color: Colors.white, size: 24),
        )
      ],
    );
  }

  Widget _mBody(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
      return DistributorsListItemWidget();
    });
  }

}