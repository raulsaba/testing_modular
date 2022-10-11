import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:testing_modular/app/core/usecases/usecase.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';

import '../entities/crud_entity.dart';

class Create implements UseCase<Crud, CreateParams> {
  final CrudRepository repository;

  Create(this.repository);

  @override
  Future<Either<Failure, Crud>> call(CreateParams params) async {
    return await repository.createCrud(params.crud);
  }
}

class CreateParams extends Equatable {
  final Crud crud;

  const CreateParams({required this.crud});

  @override
  List<Object?> get props => [crud];
}
