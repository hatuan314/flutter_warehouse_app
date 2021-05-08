import 'dart:developer';

import 'package:flutterwarehouseapp/src/data/currencies.dart';
import 'package:flutterwarehouseapp/src/data/models/currency_model.dart';

class CurrencyDataSource {
  // void updateCurrentCurrency(Currency newCurrency) {
  //   currentCurrency = newCurrency;
  //   _currencyController.add(currentCurrency);
  // }

  Future<List<CurrencyModel>> getCurrencies() async {
    List<CurrencyModel> currencies = [];
    try {
      final mapRes = currenciesMap.map((item) {
        return CurrencyModel.fromJson(item);
      }).toList();
      currencies.addAll(mapRes);
    } catch (e) {
      log("CurrencyService - getCurrencies - error: ${e.toString()}");
    }
    return currencies;
  }

// Future<String> getCurrentDeviceLocale() async {
//   try {
//     final deviceLocale = await DeviceLocale.getCurrentLocale();
//     return deviceLocale.languageCode;
//   } catch (e) {
//     throw e;
//   }
// }

// void setCurrentCurrency(User user) {
//   if (listLocalCurrency != null && listLocalCurrency.isNotEmpty) {
//     for (final Currency currency in listLocalCurrency) {
//       if (user.idCurrency == currency.id) {
//         currentCurrency = currency;
//         _currencyController.add(currency);
//       }
//     }
//   }
}
