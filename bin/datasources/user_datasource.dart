class UserDatasource {
  Future<Map<String, dynamic>?> getUserDataAtBd(String id) async {
    if (id == '123') {
      return {
        "shortName": "Victor Hugo",
        "fullName": "Victor Hugo Silva Pereira Barbosa",
        "idade": "22",
      };
    }
    return null;
  }
}
