abstract class HiveInterface<T> {
  Future<bool> create(T item);
  Future<bool> update(T item);
  Future<bool> delete(List<int> ids);
  Future<bool> clear();
}
