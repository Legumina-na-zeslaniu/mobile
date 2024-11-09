class Inventory {
  final String id;
  final String comments;
  final List<Properties> properties;

  Inventory(this.id, this.comments, this.properties);

  static Inventory fromJson(Map<String, dynamic> json) {
    return Inventory(json["id"], json["comments"], []);
  }
}

class Properties {
  final String field;
  final String value;

  Properties({required this.field, required this.value});

  static Properties fromJson(Map<String, dynamic> json) {
    return Properties(field: json['field'], value: json['value']);
  }
}
