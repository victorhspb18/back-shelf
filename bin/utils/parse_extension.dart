extension ParseExtension on String {
  dynamic toType(Type type) {
    switch (type) {
      case String:
        return this;
      case int:
        return int.parse(toString());
      default:
        return toString();
    }
  }
}
