import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutterwarehouseapp/models/invoice/product_of_invoice_model.dart';
import 'package:flutterwarehouseapp/ui/view/invoice/create_new_invoice/bloc/create_new_invoice_bloc.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';

class ProductFormDialog extends StatefulWidget {
  final CreateNewInvoiceBloc createNewInvoiceBloc;
  final ProductOfInvoiceModel productOfInvoiceModel;
  final int index;

  const ProductFormDialog(
      {Key key,
      this.createNewInvoiceBloc,
      this.productOfInvoiceModel,
      this.index})
      : super(key: key);

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

  initState() {
    super.initState();
    if (widget.productOfInvoiceModel != null) {
      _nameController.text = "${widget.productOfInvoiceModel.productName}";
      _amountController.text = '${widget.productOfInvoiceModel.amount}';
      _priceController.text = '${widget.productOfInvoiceModel.enteredPrice}';
    }
  }

  Container _buildProductForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      child: Form(
        key: _textFormKey,
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setHeight(10),
              right: ScreenUtil().setHeight(10),
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
          'Nhập sản phẩm',
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
      final String productName = _nameController.text.trim();
      final String amount = _amountController.text.trim();
      final String enteredPrice = _priceController.text.trim();
      widget.createNewInvoiceBloc.add(BtnAddDialogOnPressEvent(
          productName: productName,
          amount: amount,
          enteredPrice: enteredPrice,
          index: widget.index));
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
        iconHeader: FontAwesomeIcons.stickyNote, body: _buildProductForm());
  }
}
