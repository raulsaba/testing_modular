import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testing_modular/app/config/config.dart';
import 'package:testing_modular/app/core/error/exception.dart';
import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';
import '../../infra/datasource/crud_remote_data_source.dart';

class CrudRemoteDataSourceImpl implements ICrudRemoteDataSource {
  final Config config;
  final http.Client client;

  CrudRemoteDataSourceImpl(this.config, this.client);

  final String _baseEndPoint = 'crud';

  Future<http.Response> _getFromPath(String path) async {
    return client
        .get(Uri.http(config.baseUrl, '$_baseEndPoint/$path'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  @override
  Future<CrudModel> create(CrudModel crudModel) async {
    final response = await client
        .post(Uri.http(config.baseUrl, '$_baseEndPoint/'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }, body: {
      'crud': crudModel.toJson(),
    });
    if (response.statusCode == 201) {
      return CrudModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> delete(int id) async {
    final response = await client
        .delete(Uri.http(config.baseUrl, '$_baseEndPoint/$id'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CrudModel>> index() async {
    final response = await _getFromPath('');
    if (response.statusCode == 200) {
      return CrudModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CrudModel> show(int id) async {
    final response = await _getFromPath("$id");
    if (response.statusCode == 200) {
      return CrudModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CrudModel> update(int id, CrudModel crudModel) async {
    final response = await client
        .put(Uri.http(config.baseUrl, '$_baseEndPoint/$id'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }, body: {
      'crud': crudModel.toJson(),
    });
    if (response.statusCode == 200) {
      return CrudModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
