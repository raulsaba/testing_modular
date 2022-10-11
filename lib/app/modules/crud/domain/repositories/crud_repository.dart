import 'package:dartz/dartz.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';

abstract class CrudRepository {
  Future<Either<Failure, Crud>> showCrud(int id);
  Future<Either<Failure, List<Crud>>> indexCrud();
  Future<Either<Failure, Crud>> createCrud(Crud crud);
  Future<Either<Failure, bool>> deleteCrud(int id);
  Future<Either<Failure, Crud>> updateCrud(int id, Crud crud);
}
