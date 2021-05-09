import 'package:flutterwarehouseapp/src/data/data_sources/local/pref.dart';

class AppPreference {
  Pref pref;

  AppPreference({this.pref});

  Future saveSession() => pref.saveData(Key.session.key, true);

  Future<bool> getIsSession() async {
    return await pref.getData<bool>(Key.session.key);
  }
}

enum Key { session }

extension KeyExtension on Key {
  String get key {
    switch (this) {
      case Key.session:
        return 'SESSION';
      default:
        return null;
    }
  }
}
