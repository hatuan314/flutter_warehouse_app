import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwarehouseapp/models/invoice/product_of_invoice_model.dart';

import 'package:flutterwarehouseapp/ui/view/invoice/create_new_invoice/bloc/create_new_invoice_bloc.dart';
import 'package:flutterwarehouseapp/ui/view/invoice/create_new_invoice/widgets/widgets.dart';
import 'package:flutterwarehouseapp/ui/widgets/widgets.dart';

class CreateNewInvoiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateNewInvoiceScreenState();
}

class _CreateNewInvoiceScreenState extends State<CreateNewInvoiceScreen> {
  Widget _mAppBar() {
    return HeaderAppBar(
      title: 'Tạo hoá đơn',
      actions: <Widget>[
        IconButton(
          onPressed: () => debugPrint('Save'),
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _mBody(CreateNewInvoiceState state) {
    if (state is CreateNewInvoiceInitialState ||
        state is CreateNewInvoiceLoadState) return _buildContent(state);
    return _buildDefaut();
  }

  Widget _buildContent(CreateNewInvoiceState state) {
    return Stack(
      children: <Widget>[
        _buildInvoiceForm(state),
        Visibility(
          visible: state is CreateNewInvoiceLoadState,
          child: _buildLoading(),
        )
      ],
    );
  }

  Container _buildInvoiceForm(CreateNewInvoiceState state) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _formHeader(),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            if (state is CreateNewInvoiceInitialState)
              return _productItemForm(
                  context, state.allProductsOfInvoice[index], index);
            return Container();
          },
                  childCount: state is CreateNewInvoiceInitialState
                      ? state.allProductsOfInvoice.length
                      : 0)),
          SliverToBoxAdapter(
            child: _buildSubTotal(state),
          )
        ],
      ),
    );
  }

  Widget _buildSubTotal(CreateNewInvoiceState state) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12)),
      child: Column(
        children: <Widget>[
          Visibility(
            visible: state is CreateNewInvoiceInitialState
                ? state.allProductsOfInvoice.isNotEmpty
                : false,
            child: Divider(
              thickness: 0.75,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text('TỔNG:',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w700)),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  state is CreateNewInvoiceInitialState
                      ? state.allProductsOfInvoice.isNotEmpty
                          ? '12.000.000 đ'
                          : '0 đ'
                      : '0 đ',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _productItemForm(BuildContext context,
      ProductOfInvoiceModel productOfInvoiceModel, int index) {
    return Padding(
      padding: EdgeInsets.only(
          right: ScreenUtil().setWidth(12),
          top: ScreenUtil().setHeight(5),
          bottom: ScreenUtil().setHeight(5)),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => _btnRemoveOnPress(index),
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
            ),
          ),
          Expanded(
              child: InkWell(
                  onTap: () => _showProductFormDialog(
                      productOfInvoiceModel: productOfInvoiceModel,
                      index: index),
                  child: ProductFormWidget(
                      productOfInvoiceModel: productOfInvoiceModel))),
        ],
      ),
    );
  }

  Widget _formHeader() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        Row(
          children: <Widget>[
            Expanded(flex: 15, child: Icon(Icons.today, color: Colors.black87)),
            Expanded(
              flex: 85,
              child: Text(
                '16/05/2020',
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(18)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(8),
        ),
        Row(
          children: <Widget>[
            Expanded(flex: 15, child: Icon(Icons.group, color: Colors.black87)),
            Expanded(
              flex: 85,
              child: Text(
                'Nhà phân phối',
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(18)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(12),
              top: ScreenUtil().setHeight(12),
              right: ScreenUtil().setWidth(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Danh sách sản phẩm',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => _showProductFormDialog(),
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.indigo[800],
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black38,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLoading() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: LoadingView(),
    );
  }

  Widget _buildDefaut() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      alignment: Alignment.center,
      child: Text('Không có dữ liệu',
          style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.w600)),
    );
  }

  _showProductFormDialog(
      {ProductOfInvoiceModel productOfInvoiceModel, int index}) {
    var _createNewInvoiceBloc = BlocProvider.of<CreateNewInvoiceBloc>(context);
    showDialog(
        context: context,
        builder: (BuildContext context) => Center(
                child: ProductFormDialog(
              createNewInvoiceBloc: _createNewInvoiceBloc,
              productOfInvoiceModel: productOfInvoiceModel,
              index: index,
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CreateNewInvoiceBloc, CreateNewInvoiceState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.indigo[800],
        appBar: _mAppBar(),
        body: _mBody(state),
      );
    });
  }

  _btnRemoveOnPress(int index) {
    BlocProvider.of<CreateNewInvoiceBloc>(context)
        .add(BtnRemoveProductOfInvoiceOnPressEvent(index));
  }
}
