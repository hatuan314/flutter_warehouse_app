import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/src/data/colors.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';

final DistributorEntity distributorMock = DistributorEntity(
  name: "Tuan Hoang",
  phones: [
    '0353458490',
    '0123456789',
  ],
  emails: [
    'hatuan314@gmail.com',
    'tuanha1@hybrid-technologies.vn',
  ],
  color: ColorUtils.parseInt(colors[0]),
  createAt: DateTime.now(),
  lastUpdate: DateTime.now(),
);
