import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/create_category_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/catagory/create_category/widgets/body_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

class CreateCategoryScreen extends StatelessWidget {
  final String title;
  final CategoryEntity category;

  final TextEditingController _nameController = TextEditingController();

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
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.of(context).pop();
      },
      title: title ?? CreateCategoryConstants.createCategory,
      child: BodyWidget(
        nameController: _nameController,
      ),
    );
  }
}
