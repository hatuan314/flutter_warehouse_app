import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/bloc/distributor_bloc.dart';
import 'package:flutterwarehouseapp/ui/widgets/base_dialog.dart';

class FilterDistributorsDialog extends StatelessWidget {
  final DistributorBloc distributorBloc;

  FilterDistributorsDialog(this.distributorBloc);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseDialog(
      iconHeader: Icons.sort,
      body: _buildContent(context),
    );
  }

  _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => _btnFilterOptionOnPress(context, 0),
          child: Text('A - Z',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w500)),
        ),
        Divider(color: Colors.black26, thickness: 1),
        InkWell(
          onTap: () => _btnFilterOptionOnPress(context, 1),
          child: Text(
            'Z - A',
            style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
      ],
    );
  }

  _btnFilterOptionOnPress(BuildContext context, int index) {
    distributorBloc.add(BtnFilterDistributorsOptionOnPressEvent(index));
    Navigator.of(context).pop();
  }

}
