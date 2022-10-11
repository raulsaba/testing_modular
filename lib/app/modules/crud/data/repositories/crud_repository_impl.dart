import 'package:testing_modular/app/core/error/exception.dart';
import 'package:testing_modular/app/core/network/network_info.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_local_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_remote_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';

class CrudRepositoryImpl implements CrudRepository {
  final NetworkInfo networkInfo;
  final CrudRemoteDataSourceImpl remoteDataSource;
  final CrudLocalDataSourceImpl localDataSource;

  CrudRepositoryImpl(
      this.networkInfo, this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, Crud>> createCrud(Crud crud) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCrud =
            await remoteDataSource.create(CrudModel.fromCrud(crud));
        return Right(remoteCrud);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCrud(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.delete(id);
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Either<Failure, List<Crud>>> indexCrud() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCrudList = await remoteDataSource.index();
        await localDataSource.saveCrudListOnCache(remoteCrudList);
        return Right(remoteCrudList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCrudList = await localDataSource.getCrudListFromCache();
        return Right(localCrudList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Crud>> showCrud(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCrud = await remoteDataSource.show(id);
        return Right(remoteCrud);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Either<Failure, Crud>> updateCrud(int id, Crud crud) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCrud =
            await remoteDataSource.update(id, CrudModel.fromCrud(crud));
        return Right(remoteCrud);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw NetworkException();
    }
  }
}
