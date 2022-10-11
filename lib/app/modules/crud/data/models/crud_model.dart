import '../../domain/entities/crud_entity.dart';

class CrudModel extends Crud {
  const CrudModel({super.id, required super.name, required super.description});

  factory CrudModel.fromJson(Map<String, dynamic> json) {
    return CrudModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  static List<CrudModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CrudModel.fromJson(json)).toList();
  }

  factory CrudModel.fromCrud(Crud crud) {
    return CrudModel(
      id: crud.id,
      name: crud.name,
      description: crud.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
