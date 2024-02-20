abstract class Dao<T> {
  Future<bool> create(T value);
  Future<bool> update(T value);
  Future<T?> findOne(String id);
  Future<List<T>> findAll();
  Future<bool> delete(String id);
}
