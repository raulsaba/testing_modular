import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:testing_modular/app/core/usecases/usecase.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';

import '../entities/crud_entity.dart';

class Update implements UseCase<Crud, UpdateParams> {
  final CrudRepository repository;

  Update(this.repository);

  @override
  Future<Either<Failure, Crud>> call(UpdateParams params) async {
    return await repository.updateCrud(params.id, params.crud);
  }
}

class UpdateParams extends Equatable {
  final int id;
  final Crud crud;

  const UpdateParams({required this.id, required this.crud});

  @override
  List<Object?> get props => [id, crud];
}
