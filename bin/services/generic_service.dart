abstract class GenericService<T> {
  Future<bool> delete(String id);
  Future<T?> findOne(String? id);
  Future<List<T>> listAll();
  Future<T> save(T value);
}
