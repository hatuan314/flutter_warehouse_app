abstract class CommonRepository {

  Future<bool> setData<T>(T entity);

  Future<String> setDataCloud<T>(T entity);

  Future<int> setDataLocal<T>(T entity);

  Future setAllDataLocal<T>();

  Future<List<T>> getDataCloudList<T>();

  Future<List<T>> getDataLocalList<T>();

  Future updateDataCloud<T>(T entity);

  Future updateByKey<T>(T entity, int key);

  Future updateByIndex<T>(T entity, int index);
}