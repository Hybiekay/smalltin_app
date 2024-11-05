
// Main response model
class FieldResponse {
  final String message;
  final List<Field> fields;

  FieldResponse({
    required this.message,
    required this.fields,
  });

  factory FieldResponse.fromJson(Map<String, dynamic> json) {
    return FieldResponse(
      message: json['message'],
      fields: List<Field>.from(json['fields'].map((field) => Field.fromJson(field))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'fields': fields.map((field) => field.toJson()).toList(),
    };
  }
}

// Field model
class Field {
  final int id;
  final String name;
  final String color;
  final int size;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubField>? subFields;

  Field({
    required this.id,
    required this.name,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
    required this.subFields,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      size: json['size'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      subFields: List<SubField>.from(json['sub_fields'].map((subField) => SubField.fromJson(subField))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'size': size,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sub_fields': subFields?.map((subField) => subField.toJson()).toList(),
    };
  }
}

// SubField model
class SubField {
  final int id;
  final int fieldId;
  final String name;
  final String color;
  final int size;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubField({
    required this.id,
    required this.fieldId,
    required this.name,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubField.fromJson(Map<String, dynamic> json) {
    return SubField(
      id: json['id'],
      fieldId: json['field_id'],
      name: json['name'],
      color: json['color'],
      size: json['size'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field_id': fieldId,
      'name': name,
      'color': color,
      'size': size,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
