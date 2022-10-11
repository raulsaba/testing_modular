import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/config/config.dart';
import 'package:testing_modular/app/core/error/exception.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_remote_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';

import '../../fixtures/crud_fixtures_reader.dart';
import 'crud_remote_test.mocks.dart';

@GenerateMocks([http.Client, Config])
void main() {
  late MockClient mockClient;
  late MockConfig mockConfig;
  late CrudRemoteDataSourceImpl sut;

  setUp(() {
    mockClient = MockClient();
    mockConfig = MockConfig();
    sut = CrudRemoteDataSourceImpl(mockConfig, mockClient);
  });

  group("crud local datasource", () {
    String tBaseUrl = "tBaseUrl";
    String tBaseEndPoint = 'crud';

    void setUpConfig() {
      when(mockConfig.baseUrl).thenReturn(tBaseUrl);
    }

    void setUpMockClientGetError500() =>
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response('Internal Server Error', 500));

    void setUpMockClientPutError500() => when(mockClient.put(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('Internal Server Error', 500));

    void setUpMockClientPostError500() => when(mockClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('Internal Server Error', 500));

    void setUpMockClientDeleteError500() =>
        when(mockClient.delete(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response('Internal Server Error', 500));

    group("index", () {
      final tCrudModelList =
          CrudModel.fromJsonList(json.decode(crudFixture('crud_list')));

      void setUpMockCrudGetList200Response() =>
          when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => http.Response(crudFixture('crud_list'), 200));
      test(
        "should make a GET request on the URL without any data on the endpoint",
        () async {
          setUpMockCrudGetList200Response();
          setUpConfig();

          await sut.index();

          verify(mockClient.get(Uri.http(tBaseUrl, '$tBaseEndPoint/'),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
        },
      );
      test(
        "should make a GET request and return a list of CrudModel from the URL",
        () async {
          setUpMockCrudGetList200Response();
          setUpConfig();

          final result = await sut.index();

          expect(result, equals(tCrudModelList));
        },
      );
      test(
        "should throw a ServerException when the response status is not 200",
        () async {
          setUpMockClientGetError500();
          setUpConfig();

          final call = sut.index;

          expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
        },
      );
    });

    group("show", () {
      final tCrudModel = CrudModel.fromJson(json.decode(crudFixture('crud')));

      const tId = 1;

      void setUpMockCrudGet200Response() =>
          when(mockClient.get(any, headers: anyNamed('headers')))
              .thenAnswer((_) async => http.Response(crudFixture('crud'), 200));

      test(
        "should make a GET request with a number in the endpoint",
        () async {
          setUpMockCrudGet200Response();
          setUpConfig();

          await sut.show(tId);

          verify(mockClient.get(Uri.http(tBaseUrl, '$tBaseEndPoint/$tId'),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
        },
      );

      test(
        "should make a POST request and return a CrudModel from the URL",
        () async {
          setUpMockCrudGet200Response();
          setUpConfig();

          final result = await sut.show(tId);

          expect(result, equals(tCrudModel));
        },
      );

      test(
        "should throw a ServerException when the response status is not 200",
        () async {
          setUpMockClientGetError500();
          setUpConfig();

          final call = sut.show;

          expect(
              () => call(tId), throwsA(const TypeMatcher<ServerException>()));
        },
      );
    });

    group("create", () {
      void setUpPOST201Response() => when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(crudFixture('crud'), 201));

      final tCrudModel = CrudModel.fromJson(json.decode(crudFixture('crud')));

      test(
        "should make a POST request without any data on the endpoint",
        () async {
          setUpPOST201Response();
          setUpConfig();

          await sut.create(tCrudModel);

          verify(
              mockClient.post(Uri.http(tBaseUrl, '$tBaseEndPoint/'), headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          }, body: {
            'crud': tCrudModel.toJson(),
          }));
        },
      );

      test(
        "should make a POST request and return a CrudModel from the URL",
        () async {
          setUpPOST201Response();
          setUpConfig();

          final result = await sut.create(tCrudModel);

          expect(result, equals(tCrudModel));
        },
      );

      test(
        "should throw a ServerException when the response status is not 201",
        () async {
          setUpMockClientPostError500();
          setUpConfig();

          final call = sut.create;

          expect(() => call(tCrudModel),
              throwsA(const TypeMatcher<ServerException>()));
        },
      );
    });

    group("update", () {
      void setUpPUT200Response() => when(mockClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(crudFixture('crud'), 200));

      final tCrudModel = CrudModel.fromJson(json.decode(crudFixture('crud')));

      const int tId = 1;

      test(
        "should make a PUT request with a number on the endpoint",
        () async {
          setUpPUT200Response();
          setUpConfig();

          await sut.update(tId, tCrudModel);

          verify(mockClient
              .put(Uri.http(tBaseUrl, '$tBaseEndPoint/$tId'), headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          }, body: {
            'crud': tCrudModel.toJson(),
          }));
        },
      );

      test(
        "should make a PUT request and return a CrudModel from the URL",
        () async {
          setUpPUT200Response();
          setUpConfig();

          final result = await sut.update(tId, tCrudModel);

          expect(result, equals(tCrudModel));
        },
      );

      test(
        "should throw a ServerException when the response status is not 200",
        () async {
          setUpMockClientPutError500();
          setUpConfig();

          final call = sut.update;

          expect(() => call(tId, tCrudModel),
              throwsA(const TypeMatcher<ServerException>()));
        },
      );
    });

    group("delete", () {
      const tId = 1;

      void setUpMockCrudDelete200Response() =>
          when(mockClient.delete(any, headers: anyNamed('headers')))
              .thenAnswer((_) async => http.Response('OK', 200));

      test(
        "should make a DELETE request with a number in the endpoint",
        () async {
          setUpMockCrudDelete200Response();
          setUpConfig();

          await sut.delete(tId);

          verify(mockClient.delete(Uri.http(tBaseUrl, '$tBaseEndPoint/$tId'),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
        },
      );

      test(
        "should make a DELETE request and return a True from the URL",
        () async {
          setUpMockCrudDelete200Response();
          setUpConfig();

          final result = await sut.delete(tId);

          expect(result, equals(true));
        },
      );

      test(
        "should throw a ServerException when the response status is not 200",
        () async {
          setUpMockClientDeleteError500();
          setUpConfig();

          final call = sut.delete;

          expect(
              () => call(tId), throwsA(const TypeMatcher<ServerException>()));
        },
      );
    });
  });
}
