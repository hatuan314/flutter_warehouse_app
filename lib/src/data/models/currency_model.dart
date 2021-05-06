import 'package:flutterwarehouseapp/src/domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  int id;
  String name;
  String code;
  String locale;
  String isoCode;

//  'vi', 'en-us',
  String flag;

  CurrencyModel({
    this.id,
    this.name,
    this.code,
    this.locale,
    this.flag,
    this.isoCode,
  }): super(id: id, name: name, code: code, locale: locale, flag: flag, isoCode: isoCode);

  CurrencyModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        code = map['code'],
        locale = map['locale'],
        flag = map['flag'],
        isoCode = map['isoCode'];

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    locale = json['locale'];
    isoCode = json['isoCode'];
    flag = json['flag'];
  }
}