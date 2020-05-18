import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductFormDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  FocusNode _nameNode = FocusNode();
  FocusNode _amountNode = FocusNode();
  FocusNode _priceNode = FocusNode();

  GlobalKey<FormState> _textFormKey = GlobalKey<FormState>();

  Container _buildProductForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
      child: Form(
        key: _textFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(20),
              horizontal: ScreenUtil().setWidth(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _headerForm(),
              _productTextFieldGroup(),
              _buildButtonGroup()],
          ),
        ),
      ),
    );
  }

  Widget _headerForm() {
    return Column(
      children: <Widget>[
        SizedBox(height: ScreenUtil().setHeight(20)),
        Text('Nhập sản phẩm', style: TextStyle(
            color: Colors.black87,
            fontSize: ScreenUtil().setSp(28),
            fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,),
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
            nextNode: _amountNode,
            hintText: 'Tên sản phẩm',
            validator: (value) {
              if (value.isEmpty) return "Trường này không được phép bỏ trống";
              return null;
            }),
        SizedBox(
          height: 15,
        ),
        MyTextForm(
            controller: _amountController,
            keyboardType: TextInputType.number,
            currentNode: _amountNode,
            nextNode: _priceNode,
            hintText: 'Số lượng sản phẩm',
            validator: (value) {
              if (value.isEmpty) return "Trường này không được phép bỏ trống";
              return null;
            }),
        SizedBox(height: 15),
        MyTextForm(
            controller: _priceController,
            keyboardType: TextInputType.number,
            currentNode: _priceNode,
            hintText: 'Giá nhâp vào',
            validator: (value) {
              if (value.isEmpty) return "Trường này không được phép bỏ trống";
              return null;
            }),
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
      print('Save');
    }
  }

  void _btnCancelOnPress() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _buildProductForm(),
          _buildHeaderAppBar()
        ],
      ),
    );
  }

  Widget _buildHeaderAppBar() {
    return Container(
      height: ScreenUtil().setHeight(70),
      width: ScreenUtil().setWidth(70),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.indigo[800]),
      alignment: Alignment.center,
      child: Icon(
        FontAwesomeIcons.stickyNote,
        color: Colors.white,
        size: ScreenUtil().setHeight(34),
      ),
    );
  }
}
