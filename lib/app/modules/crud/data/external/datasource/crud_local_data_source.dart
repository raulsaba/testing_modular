// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:testing_modular/app/core/error/exception.dart';
import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../infra/datasource/crud_local_data_source.dart';

const CACHED_CRUD_LIST = 'CACHED_CRUD_LIST';

class CrudLocalDataSourceImpl implements ICrudLocalDataSource {
  final SharedPreferences sharedPreferences;

  CrudLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> clearCache() async {
    return await sharedPreferences.clear();
  }

  @override
  Future<List<CrudModel>> getCrudListFromCache() {
    final jsonString = sharedPreferences.getString(CACHED_CRUD_LIST);
    if (jsonString != null) {
      return Future.value(CrudModel.fromJsonList(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> saveCrudListOnCache(List<CrudModel> crudModelList) {
    return sharedPreferences.setString(
        CACHED_CRUD_LIST, jsonEncode(crudModelList));
  }
}
