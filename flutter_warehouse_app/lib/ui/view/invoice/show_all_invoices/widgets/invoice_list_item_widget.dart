import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';

class InvoiceListItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(5))),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setHeight(12),
          vertical: ScreenUtil().setWidth(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.indigo[800],
            ),
            margin: EdgeInsets.only(left: 5, top: 8),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.group,
                  color: Colors.white,
                  size: ScreenUtil().setSp(18),
                ),
                SizedBox(width: 8),
                Text('Distributor 1',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ProductFormWidget(),
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              color: Colors.indigo,
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                    child: Text('TỔNG:',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '1.000.000 đ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
