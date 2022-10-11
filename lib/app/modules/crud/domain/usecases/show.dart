import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:testing_modular/app/core/usecases/usecase.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';

import '../entities/crud_entity.dart';

class Show implements UseCase<Crud, ShowParams> {
  final CrudRepository repository;

  Show(this.repository);

  @override
  Future<Either<Failure, Crud>> call(ShowParams params) async {
    return await repository.showCrud(params.id);
  }
}

class ShowParams extends Equatable {
  final int id;

  const ShowParams({required this.id});

  @override
  List<Object?> get props => [id];
}
