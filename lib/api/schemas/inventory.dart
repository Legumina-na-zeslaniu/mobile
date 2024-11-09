import 'dart:ffi';

class Inventory {
  final String? id;
  final String? comments;
  final String? buildingId;
  final Localization? localization;
  final List<String>? files;
  final List<Properties>? properties;

  Inventory(
      {this.id,
      this.comments,
      this.properties,
      this.files,
      this.buildingId,
      required this.localization});

  static Inventory fromJson(Map<String, dynamic> json) {
    return Inventory(
        id: json["id"],
        comments: json["comments"],
        buildingId: json["buildingId"],
        files: json['files'] == null
            ? []
            : (json['files'] as List).map((e) => e as String).toList(),
        localization: json['localization'] != null
            ? Localization.fromJson(json['localization'])
            : null,
        properties: (json['properties'] as List)
            .map((prop) => Properties.fromJson(prop))
            .toList());
  }
}

class Localization {
  final double x;
  final double y;
  final double z;

  Localization({required this.x, required this.y, required this.z});

  static Localization fromJson(Map<String, dynamic> json) {
    return Localization(
        x: (json['x'] as int).toDouble(),
        y: (json['y'] as int).toDouble(),
        z: (json['z'] as int).toDouble());
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
