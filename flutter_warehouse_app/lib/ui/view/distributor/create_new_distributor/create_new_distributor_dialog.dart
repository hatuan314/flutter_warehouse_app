import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterwarehouseapp/ui/view/distributor/bloc/distributor_bloc.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateNewDistributorDialog extends StatefulWidget {
  final DistributorBloc distributorBloc;

  CreateNewDistributorDialog(this.distributorBloc);

  @override
  State<StatefulWidget> createState() => _CreateNewDistributorDialogState();
}

class _CreateNewDistributorDialogState
    extends State<CreateNewDistributorDialog> {
  GlobalKey<FormState> _textFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneOneController = TextEditingController();
  TextEditingController _phoneTwoController = TextEditingController();

  FocusNode _nameNode = FocusNode();
  FocusNode _addressNode = FocusNode();
  FocusNode _phoneOneNode = FocusNode();
  FocusNode _phoneTwoNode = FocusNode();

  Widget _buildContent() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
      child: Form(
        key: _textFormKey,
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setHeight(20),
              top: ScreenUtil().setWidth(20),
              right: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setWidth(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _headerForm(),
              _productTextFieldGroup(),
              _buildButtonGroup()
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerForm() {
    return Column(
      children: <Widget>[
        SizedBox(height: ScreenUtil().setHeight(20)),
        Text(
          'Nhà phân phối',
          style: TextStyle(
              color: Colors.black87,
              fontSize: ScreenUtil().setSp(28),
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: ScreenUtil().setHeight(25))
      ],
    );
  }

  Column _productTextFieldGroup() {
    return Column(
      children: <Widget>[
        MyTextForm(
            controller: _nameController,
            currentNode: _nameNode,
            nextNode: _addressNode,
            hintText: 'Tên nhà phân phối',
            validator: (value) {
              if (value.isEmpty) return "Trường này không được phép bỏ trống";
              return null;
            }),
        SizedBox(
          height: 15,
        ),
        MyTextForm(
            controller: _addressController,
            currentNode: _addressNode,
            nextNode: _phoneOneNode,
            hintText: 'Địa chỉ',
            validator: (value) {
              if (value.isEmpty) return "Trường này không được phép bỏ trống";
              return null;
            }),
        SizedBox(height: 15),
        MyTextForm(
            controller: _phoneOneController,
            keyboardType: TextInputType.number,
            currentNode: _phoneOneNode,
            nextNode: _phoneTwoNode,
            hintText: 'Số điện thoại 1',
            validator: (value) {
              if (value.isEmpty) return "Trường này không được phép bỏ trống";
              return null;
            }),
        SizedBox(height: 15),
        MyTextForm(
            controller: _phoneTwoController,
            keyboardType: TextInputType.number,
            currentNode: _phoneTwoNode,
            hintText: 'Số điện thoại 2',
        validator: (value) => null),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
      ],
    );
  }

  Row _buildButtonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            onPressed: () => _btnCancelOnPress(),
            color: Colors.red,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(FontAwesomeIcons.times,
                      size: ScreenUtil().setHeight(20), color: Colors.white),
                  Text(
                    'Huỷ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            onPressed: () => _btnCreateOnPress(),
            color: Colors.indigo[800],
            child: Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.check,
                    size: ScreenUtil().setHeight(20),
                    color: Colors.white,
                  ),
                  Text(
                    'Thêm',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _btnCreateOnPress() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_textFormKey.currentState.validate()) {
      final String name = _nameController.text.trim();
      final String address = _addressController.text.trim();
      final String phoneOne = _phoneOneController.text.trim();
      final String phoneTwo = _phoneTwoController.text.trim();

      widget.distributorBloc.add(BtnAddDistributorOnPressEvent(
          name, address, phoneOne,
          phoneTwo: phoneTwo));
      Navigator.of(context).pop();
    }
  }

  void _btnCancelOnPress() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseDialog(
      iconHeader: FontAwesomeIcons.userPlus,
      body: _buildContent(),
    );
  }
}