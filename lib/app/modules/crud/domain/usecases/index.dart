import 'package:dartz/dartz.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:testing_modular/app/core/usecases/usecase.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';

import '../entities/crud_entity.dart';

class Index implements UseCase<List<Crud>, NoParams> {
  final CrudRepository repository;

  Index(this.repository);

  @override
  Future<Either<Failure, List<Crud>>> call(NoParams params) async {
    return await repository.indexCrud();
  }
}
