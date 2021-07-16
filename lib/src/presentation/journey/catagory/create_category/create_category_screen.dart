import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/bloc/create_category_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/create_category_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/widgets/body_widget.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

import 'bloc/create_category_state.dart';

class CreateCategoryScreen extends StatelessWidget {
  final String title;
  final CategoryEntity category;

  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateCategoryScreen({
    Key key,
    @required this.title,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      _nameController.text = category.name;
    }
    return BlocConsumer<CreateCategoryBloc, CreateCategoryState>(listener: (context, state) {
      if (state.viewState == ViewState.success) {
        Navigator.of(context).pop(true);
      }
    }, builder: (context, state) {
      return ScaffoldWidget(
        isLeading: true,
        onLeading: () {
          Navigator.of(context).pop();
        },
        title: title ?? CreateCategoryConstants.createCategory,
        child: Form(
          key: _formKey,
          child: BodyWidget(
            nameController: _nameController,
            onCreateCategory: () {
              if (_formKey.currentState.validate())
                BlocProvider.of<CreateCategoryBloc>(context)
                    .add(OnPressCreateEvent(categoryName: _nameController.text.trim()));
            },
          ),
        ),
      );
    });
  }
}
