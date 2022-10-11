// Mocks generated by Mockito 5.3.2 from annotations
// in testing_modular/test/app/modules/crud/domain/usecases/create_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:testing_modular/app/core/error/failure.dart' as _i5;
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart'
    as _i6;
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CrudRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrudRepository extends _i1.Mock implements _i3.CrudRepository {
  MockCrudRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>> showCrud(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCrud,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>>.value(
            _FakeEither_0<_i5.Failure, _i6.Crud>(
          this,
          Invocation.method(
            #showCrud,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Crud>>> indexCrud() =>
      (super.noSuchMethod(
        Invocation.method(
          #indexCrud,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Crud>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Crud>>(
          this,
          Invocation.method(
            #indexCrud,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Crud>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>> createCrud(_i6.Crud? crud) =>
      (super.noSuchMethod(
        Invocation.method(
          #createCrud,
          [crud],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>>.value(
            _FakeEither_0<_i5.Failure, _i6.Crud>(
          this,
          Invocation.method(
            #createCrud,
            [crud],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteCrud(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteCrud,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteCrud,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>> updateCrud(
    int? id,
    _i6.Crud? crud,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateCrud,
          [
            id,
            crud,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>>.value(
            _FakeEither_0<_i5.Failure, _i6.Crud>(
          this,
          Invocation.method(
            #updateCrud,
            [
              id,
              crud,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Crud>>);
}
