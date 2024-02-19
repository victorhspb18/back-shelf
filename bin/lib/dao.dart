abstract class Dao<T> {
  Future<T?> create(T value);
  Future<T?> update(T value);
  Future<T?> findOne(String id);
  Future<List<T>> findAll();
  Future<bool> delete(String id);
}
