extension JsonExtension on Map {
  String parseJsonAsString({required String key, String defValue = ''}) {
    return this[key] ?? defValue;
  }

  int parseJsonAsInt({required String key, int defValue = 0}) {
    return this[key] ?? defValue;
  }

  double parseJsonAsDouble({required String key, double defaultValue = 0.0}) {
    return this[key] is double ? this[key] : double.parse(this[key] ?? '$defaultValue');
  }

  bool parseJsonAsBool({required String key, defValue = false}) {
    return this[key] ?? defValue;
  }

  DateTime? tryParseValueAsDateTime({required String key}) {
    DateTime? result;
    if (this[key] != null) {
      result = DateTime.tryParse(this[key]);
    }
    return result;
  }
}
