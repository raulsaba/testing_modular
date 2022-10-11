import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/core/error/exception.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:testing_modular/app/core/network/network_info.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_local_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_remote_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';
import 'package:testing_modular/app/modules/crud/data/repositories/crud_repository_impl.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';

import 'crud_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, CrudLocalDataSourceImpl, CrudRemoteDataSourceImpl])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockCrudLocalDataSourceImpl mockCrudLocalDataSourceImpl;
  late MockCrudRemoteDataSourceImpl mockCrudRemoteDataSourceImpl;
  late CrudRepositoryImpl sut;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockCrudLocalDataSourceImpl = MockCrudLocalDataSourceImpl();
    mockCrudRemoteDataSourceImpl = MockCrudRemoteDataSourceImpl();
    sut = CrudRepositoryImpl(mockNetworkInfo, mockCrudRemoteDataSourceImpl,
        mockCrudLocalDataSourceImpl);
  });

  group('crud repository impl', () {
    void setUpDeviceIsOnline() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
    }

    void testDeviceIsOfline(Function call) {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      expect(call(), throwsA(const TypeMatcher<NetworkException>()));
    }

    group("indexCrud", () {
      const List<CrudModel> tCrudModelList = [
        CrudModel(id: 1, name: "name 1", description: "description 1"),
        CrudModel(id: 2, name: "name 2", description: "description 2"),
        CrudModel(id: 3, name: "name 3", description: "description 3"),
        CrudModel(id: 4, name: "name 4", description: "description 4"),
      ];

      const List<Crud> tCruds = tCrudModelList;

      test(
        "should verify if device is online",
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          when(mockCrudRemoteDataSourceImpl.index())
              .thenAnswer((_) async => tCrudModelList);
          when(mockCrudLocalDataSourceImpl.saveCrudListOnCache(any))
              .thenAnswer((_) async => true);

          sut.indexCrud();

          verify(mockNetworkInfo.isConnected);
        },
      );

      group("device is online", () {
        setUpDeviceIsOnline();

        test(
          "should return the remote data when the call on remote dataSource is successful",
          () async {
            when(mockCrudRemoteDataSourceImpl.index())
                .thenAnswer((_) async => tCrudModelList);
            when(mockCrudLocalDataSourceImpl.saveCrudListOnCache(any))
                .thenAnswer((_) async => true);

            final result = await sut.indexCrud();

            verify(mockCrudRemoteDataSourceImpl.index());
            expect(result, equals(const Right(tCruds)));
          },
        );

        test(
          "should salve data on cache when the call on remote dataSource is successful",
          () async {
            when(mockCrudRemoteDataSourceImpl.index())
                .thenAnswer((_) async => tCrudModelList);
            when(mockCrudLocalDataSourceImpl.saveCrudListOnCache(any))
                .thenAnswer((_) async => true);

            await sut.indexCrud();

            verify(mockCrudLocalDataSourceImpl
                .saveCrudListOnCache(tCrudModelList));
          },
        );

        test(
          "should return a Failure when the remote dataSource throws a ServerException",
          () async {
            when(mockCrudRemoteDataSourceImpl.index())
                .thenThrow(ServerException());

            final result = await sut.indexCrud();

            verify(mockCrudRemoteDataSourceImpl.index());

            expect(result, equals(Left(ServerFailure())));
          },
        );
      });

      group("device is offline", () {
        test(
          "should not have interactions with remote dataSource when the device is offline",
          () async {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
            when(mockCrudLocalDataSourceImpl.getCrudListFromCache())
                .thenAnswer((_) async => tCrudModelList);

            await sut.indexCrud();

            verifyZeroInteractions(mockCrudRemoteDataSourceImpl);
          },
        );

        test(
          "should return the cached data when has data present on cache",
          () async {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
            when(mockCrudLocalDataSourceImpl.getCrudListFromCache())
                .thenAnswer((_) async => tCrudModelList);

            final result = await sut.indexCrud();

            verify(mockCrudLocalDataSourceImpl.getCrudListFromCache());

            expect(result, equals(const Right(tCruds)));
          },
        );

        test(
          "should return a Failure when has no data present on cache",
          () async {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
            when(mockCrudLocalDataSourceImpl.getCrudListFromCache())
                .thenThrow(CacheException());

            final result = await sut.indexCrud();

            verify(mockCrudLocalDataSourceImpl.getCrudListFromCache());

            expect(result, equals(Left(CacheFailure())));
          },
        );
      });
    });

    group("showCrud", () {
      const CrudModel tCrudModel =
          CrudModel(id: 1, name: 'name', description: 'description');

      const Crud tCrud = tCrudModel;

      const int tId = 1;

      test(
        "should verify if device is online",
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          when(mockCrudRemoteDataSourceImpl.show(any))
              .thenAnswer((_) async => tCrudModel);

          sut.showCrud(tId);

          verify(mockNetworkInfo.isConnected);
        },
      );

      group('device is online', () {
        setUpDeviceIsOnline();
        test(
          "should return the remote data when the call on remote dataSource is successful",
          () async {
            when(mockCrudRemoteDataSourceImpl.show(any))
                .thenAnswer((_) async => tCrudModel);

            final result = await sut.showCrud(tId);

            verify(mockCrudRemoteDataSourceImpl.show(tId));
            expect(result, equals(const Right(tCrud)));
          },
        );

        test(
          "should return a Failure when the remote dataSource throws a ServerException",
          () async {
            when(mockCrudRemoteDataSourceImpl.show(any))
                .thenThrow(ServerException());

            final result = await sut.showCrud(tId);

            verify(mockCrudRemoteDataSourceImpl.show(tId));

            expect(result, equals(Left(ServerFailure())));
          },
        );
      });

      group("device is offline", () {
        test(
          "should throw a NetworkException when the device is Offline",
          () async {
            testDeviceIsOfline(() => sut.showCrud(tId));
          },
        );
      });
    });

    group("createCrud", () {
      const CrudModel tCrudModel =
          CrudModel(id: 1, name: 'name', description: 'description');

      const Crud tCrud = tCrudModel;

      test(
        "should verify if device is online",
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          when(mockCrudRemoteDataSourceImpl.create(any))
              .thenAnswer((_) async => tCrudModel);

          sut.createCrud(tCrudModel);

          verify(mockNetworkInfo.isConnected);
        },
      );

      group('device is online', () {
        setUpDeviceIsOnline();
        test(
          "should send and return the right data when the call on remote dataSource is successful",
          () async {
            when(mockCrudRemoteDataSourceImpl.create(any))
                .thenAnswer((_) async => tCrudModel);

            final result = await sut.createCrud(tCrudModel);

            verify(mockCrudRemoteDataSourceImpl.create(tCrudModel));
            expect(result, equals(const Right(tCrud)));
          },
        );

        test(
          "should return a Failure when the remote dataSource throws a ServerException",
          () async {
            when(mockCrudRemoteDataSourceImpl.create(any))
                .thenThrow(ServerException());

            final result = await sut.createCrud(tCrudModel);

            verify(mockCrudRemoteDataSourceImpl.create(tCrudModel));

            expect(result, equals(Left(ServerFailure())));
          },
        );
      });

      group("device is offline", () {
        test(
          "should throw a NetworkException when the device is Offline",
          () async {
            testDeviceIsOfline(() => sut.createCrud(tCrudModel));
          },
        );
      });
    });

    group("updateCrud", () {
      const CrudModel tCrudModel =
          CrudModel(id: 1, name: 'name', description: 'description');

      const Crud tCrud = tCrudModel;

      const int tId = 1;

      test(
        "should verify if device is online",
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          when(mockCrudRemoteDataSourceImpl.update(any, any))
              .thenAnswer((_) async => tCrudModel);

          sut.updateCrud(tId, tCrudModel);

          verify(mockNetworkInfo.isConnected);
        },
      );

      group('device is online', () {
        setUpDeviceIsOnline();
        test(
          "should return the remote data when the call on remote dataSource is successful",
          () async {
            when(mockCrudRemoteDataSourceImpl.update(any, any))
                .thenAnswer((_) async => tCrudModel);

            final result = await sut.updateCrud(tId, tCrudModel);

            verify(mockCrudRemoteDataSourceImpl.update(tId, tCrudModel));
            expect(result, equals(const Right(tCrud)));
          },
        );

        test(
          "should return a Failure when the remote dataSource throws a ServerException",
          () async {
            when(mockCrudRemoteDataSourceImpl.update(any, any))
                .thenThrow(ServerException());

            final result = await sut.updateCrud(tId, tCrudModel);

            verify(mockCrudRemoteDataSourceImpl.update(tId, tCrudModel));

            expect(result, equals(Left(ServerFailure())));
          },
        );
      });

      group("device is offline", () {
        test(
          "should throw a NetworkException when the device is Offline",
          () async {
            testDeviceIsOfline(() => sut.updateCrud(tId, tCrudModel));
          },
        );
      });
    });

    group("deleteCrud", () {
      const int tId = 1;

      test(
        "should verify if device is online",
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          when(mockCrudRemoteDataSourceImpl.delete(any))
              .thenAnswer((_) async => true);

          sut.deleteCrud(tId);

          verify(mockNetworkInfo.isConnected);
        },
      );

      group('device is online', () {
        setUpDeviceIsOnline();
        test(
          "should return the remote data when the call on remote dataSource is successful",
          () async {
            when(mockCrudRemoteDataSourceImpl.delete(any))
                .thenAnswer((_) async => true);

            final result = await sut.deleteCrud(tId);

            verify(mockCrudRemoteDataSourceImpl.delete(tId));
            expect(result, equals(const Right(true)));
          },
        );

        test(
          "should return a Failure when the remote dataSource throws a ServerException",
          () async {
            when(mockCrudRemoteDataSourceImpl.delete(any))
                .thenThrow(ServerException());

            final result = await sut.deleteCrud(tId);

            verify(mockCrudRemoteDataSourceImpl.delete(tId));

            expect(result, equals(Left(ServerFailure())));
          },
        );
      });

      group("device is offline", () {
        test(
          "should throw a NetworkException when the device is Offline",
          () async {
            testDeviceIsOfline(() => sut.deleteCrud(tId));
          },
        );
      });
    });
  });
}
