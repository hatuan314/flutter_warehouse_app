import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwarehouseapp/common/constants/constants.dart';
import 'package:flutterwarehouseapp/src/distributor/domain/domain.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DistributorsListItemWidget extends StatelessWidget {
  final DistributorEntity distributorEntity;

  DistributorsListItemWidget(this.distributorEntity);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPrint('distributorEntity.colorKey: ${distributorEntity.colorKey}');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 12,
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setHeight(8)),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
                child: Text('${distributorEntity.name}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.bold)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: distributorColors[distributorEntity.colorKey]
                              .backgroundColor),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '${distributorEntity.name[0].toUpperCase()}',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(36),
                            color: distributorColors[distributorEntity.colorKey]
                                .textColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(8),
                          ),
                          _distributorInforElementWidget(
                              FontAwesomeIcons.addressCard,
                              '${distributorEntity.address}'),
                          _distributorInforElementWidget(
                              FontAwesomeIcons.mobileAlt,
                              '${distributorEntity.phoneOne}'),
                          _distributorInforElementWidget(
                              FontAwesomeIcons.mobileAlt,
                              distributorEntity.phoneTwo.isEmpty
                                  ? ''
                                  : '${distributorEntity.phoneTwo}'),
                        ],
                      ))
                ],
              ),
            ],
          )),
    );
  }

  Widget _distributorInforElementWidget(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(3),
          right: ScreenUtil().setWidth(12),
          bottom: ScreenUtil().setHeight(3)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                icon,
                color: Colors.black87,
                size: ScreenUtil().setSp(18),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              '$title',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
