import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_modular/app/core/error/failure.dart';
import 'package:testing_modular/app/core/usecases/usecase.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';

class Delete implements UseCase<bool, DeleteParams> {
  final CrudRepository repository;

  Delete(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteParams params) async {
    return await repository.deleteCrud(params.id);
  }
}

class DeleteParams extends Equatable {
  final int id;

  const DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
