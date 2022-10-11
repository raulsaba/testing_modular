import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/core/error/exception.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_local_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/crud_fixtures_reader.dart';
import 'crud_local_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late CrudLocalDataSourceImpl sut;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sut = CrudLocalDataSourceImpl(mockSharedPreferences);
  });

  group("crud local datasource ", () {
    const List<CrudModel> tCrudModelList = [
      CrudModel(id: 1, name: "name 1", description: "description 1"),
      CrudModel(id: 2, name: "name 2", description: "description 2"),
      CrudModel(id: 3, name: "name 3", description: "description 3"),
      CrudModel(id: 4, name: "name 4", description: "description 4"),
    ];

    group("saveCrudListOnCache ", () {
      test(
        "should save a List of CrudModels on Cache using SharedPreferences",
        () async {
          when(mockSharedPreferences.setString(any, any))
              .thenAnswer((_) async => true);

          sut.saveCrudListOnCache(tCrudModelList);

          final expectedJsonString = jsonEncode(tCrudModelList);

          verify(mockSharedPreferences.setString(
              CACHED_CRUD_LIST, expectedJsonString));
        },
      );
    });

    group("getCrudListFromCache ", () {
      final List<CrudModel> tCrudModelList =
          CrudModel.fromJsonList(jsonDecode(crudFixture('crud_list')));

      test(
        "Should return a List of CrudModels from Cache using SharedPreferences if it has one",
        () async {
          when(mockSharedPreferences.getString(any))
              .thenReturn(crudFixture('crud_list'));

          final result = await sut.getCrudListFromCache();

          verify(mockSharedPreferences.getString(CACHED_CRUD_LIST));
          expect(result, equals(tCrudModelList));
        },
      );

      test(
        "Should throw a CacheException when no data on Cache",
        () async {
          when(mockSharedPreferences.getString(any)).thenReturn(null);

          final call = sut.getCrudListFromCache;

          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
    });

    group("clearCache ", () {
      test(
        "Should clear the CACHHED_CRUD_LIST cache",
        () async {
          when(mockSharedPreferences.clear()).thenAnswer((_) async => true);

          final result = await sut.clearCache();

          expect(result, true);
        },
      );
    });
  });
}
