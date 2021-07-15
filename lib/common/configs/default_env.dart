class DefaultConfig {
  static const splashScreenSecondTimeOut = 2;
  static const appName = 'cp_warehouse';
  static const environment = 'environment';
  static const limitRequest = 10;

  /// Collections
  // static const mainCollection = 'product';
  static const mainCollection = 'develop';
  static const unitsCollection = 'units';
  static const distributorsCollection = 'distributors';
  static const categoriesCollection = 'categories';
  static const profileCollection = 'profile';

  /// Documents
  static const profileDocument = 'profile';

  /// Field

  /// Storage
  static const expenseStorage = 'expense';
  static const profileStorage = 'profile';
  static const storagePath = '$appName/environments';
}