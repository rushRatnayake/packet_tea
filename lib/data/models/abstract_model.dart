import 'dart:convert';


abstract class AbstractModel {
  /// This function will take in a dynamic json array which
  /// contains elements that are type [E]. It is prohibited to
  /// use this function if the target array contains different
  /// runtime types.
  ///
  /// [E] is the type of each element in [jsonArray]
  /// [T] is the return type of the returning list.
  static List<T> parseJsonArray<E, T>({
    final List<dynamic> jsonArray,
    final T Function(E element) callback,
    final bool parseElementToTypeIfString = false,
  }) {
    if (jsonArray == null || jsonArray.isEmpty) return [];
    return jsonArray.fold(<T>[], (List<T> previousValue, dynamic element) {
      dynamic __element = element;
      if (parseElementToTypeIfString) {
        if (!(__element is Map<String, dynamic>)) {
          __element = jsonDecode(element) as E;
        }
      }
      if (callback != null) {
        previousValue.add(callback(__element as E));
      } else {
        previousValue.add(element as T);
      }
      return previousValue;
    });
  }

  static String safeUnwrapStringField(String string) {
    return string ?? "";
  }

  AbstractModel fromJson(final Map<String, dynamic> json);

  Map<String, dynamic> toMap();

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> cherryPickMapProps(Set<String> keys) {
    var table = toMap();
    Set<String> _internalKeys = table.keys.toSet();
    // Safe concurrent modification.
    for (var k in _internalKeys) {
      if (!keys.contains(k)) table.remove(k);
    }
    return table;
  }
}