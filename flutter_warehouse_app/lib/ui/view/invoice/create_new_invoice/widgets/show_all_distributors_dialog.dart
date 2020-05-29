import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/ui/view/invoice/create_new_invoice/bloc/create_new_invoice_bloc.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';

class ShowAllDistributorDialog extends StatelessWidget {
  final List<DistributorModel> allDistributors;
  final CreateNewInvoiceBloc createNewInvoiceBloc;

  const ShowAllDistributorDialog(
      {Key key, this.createNewInvoiceBloc, this.allDistributors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseDialog(
      iconHeader: Icons.group,
      body: Column(
        children: <Widget>[_buildContent(context), SizedBox(height: 8)],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: allDistributors.length,
        itemBuilder: (BuildContext context, int index) =>
            _distributorElementWidget(context, allDistributors, index));
  }

  Widget _distributorElementWidget(
      BuildContext context, List<DistributorModel> allDistributors, int index) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => _btnSelectDistributorOnPress(context, index),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
            child: Text('${allDistributors[index].name}',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w500)),
          ),
        ),
        Visibility(
            visible: index < allDistributors.length - 1,
            child: Divider(color: Colors.black26, thickness: 1)),
      ],
    );
  }

  _btnSelectDistributorOnPress(BuildContext context, int index) {
    createNewInvoiceBloc.add(SelectDistributorOnPressEvent(index));
    Navigator.of(context).pop();
  }
}
