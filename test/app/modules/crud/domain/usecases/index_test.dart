import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/core/usecases/usecase.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/index.dart';

import 'index_test.mocks.dart';

@GenerateMocks([CrudRepository])
void main() {
  late Index sut;
  late MockCrudRepository mockCrudRepository;

  setUp(() {
    mockCrudRepository = MockCrudRepository();
    sut = Index(mockCrudRepository);
  });

  group("crud index usecase test", () {
    const List<Crud> tCrudList = [
      Crud(id: 1, name: "name 1", description: "description 1"),
      Crud(id: 2, name: "name 2", description: "description 2"),
      Crud(id: 3, name: "name 3", description: "description 3"),
      Crud(id: 4, name: "name 4", description: "description 4"),
    ];
    test(
      "shoud return a list of cruds from the repository",
      () async {
        when(mockCrudRepository.indexCrud())
            .thenAnswer((_) async => const Right(tCrudList));

        final result = await sut(NoParams());

        expect(result, const Right(tCrudList));
        verify(mockCrudRepository.indexCrud());
      },
    );
  });
}
