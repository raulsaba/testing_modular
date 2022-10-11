import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';

import '../../fixtures/crud_fixtures_reader.dart';

void main() {
  group("crud model test", () {
    const CrudModel tCrudModel =
        CrudModel(id: 1, name: "name", description: "description");

    const List<CrudModel> tCrudModelList = [
      CrudModel(id: 1, name: "name 1", description: "description 1"),
      CrudModel(id: 2, name: "name 2", description: "description 2"),
      CrudModel(id: 3, name: "name 3", description: "description 3"),
      CrudModel(id: 4, name: "name 4", description: "description 4")
    ];

    test(
      "should be a Crud subclass",
      () async {
        expect(tCrudModel, isA<Crud>());
      },
    );

    group("fromJson", () {
      test(
        "should return a valid CrudModel from JSON with one object",
        () async {
          final Map<String, dynamic> jsonMap = json.decode(crudFixture("crud"));

          final result = CrudModel.fromJson(jsonMap);

          expect(result, tCrudModel);
        },
      );

      test(
        "should return a valid list of CrudModels from JSON with a array of objects",
        () async {
          final List<dynamic> jsonList = json.decode(crudFixture('crud_list'));

          final result = CrudModel.fromJsonList(jsonList);

          expect(result, tCrudModelList);
        },
      );
    });

    group("fromCrud", () {
      const Crud tCrud = Crud(id: 1, name: "name", description: "description");

      test(
        "should retunr a valid CrudModel when setted up with a Crud entity",
        () async {
          final result = CrudModel.fromCrud(tCrud);

          expect(result, tCrudModel);
        },
      );
    });

    group("toJson", () {
      test(
        "should return a JSON map thats contains the ",
        () async {
          final result = tCrudModel.toJson();

          const expectedJsonMap = {
            "id": 1,
            "name": "name",
            "description": "description",
          };

          expect(result, expectedJsonMap);
        },
      );
    });
  });
}
