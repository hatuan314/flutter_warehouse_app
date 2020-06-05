import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/ui/base_app_bar_widget.dart';

class ShowAllProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      appBar: BaseAppBarWidget(
        title: 'Sản phẩm',
      ),
    );
  }

}