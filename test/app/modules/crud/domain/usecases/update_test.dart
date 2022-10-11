import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/update.dart';

import 'update_test.mocks.dart';

@GenerateMocks([CrudRepository])
void main() {
  late Update sut;
  late MockCrudRepository mockCrudRepository;

  setUp(() {
    mockCrudRepository = MockCrudRepository();
    sut = Update(mockCrudRepository);
  });

  group("crud index usecase test", () {
    const int tId = 1;
    const Crud tUpdateCrud =
        Crud(name: "name update", description: "description");
    const Crud tResponseCrud =
        Crud(id: 1, name: "name update", description: "description");
    test(
      "shoud return a list of cruds from the repository",
      () async {
        when(mockCrudRepository.updateCrud(any, any))
            .thenAnswer((_) async => const Right(tResponseCrud));

        final result =
            await sut(const UpdateParams(id: tId, crud: tUpdateCrud));

        expect(result, const Right(tResponseCrud));
        verify(mockCrudRepository.updateCrud(tId, tUpdateCrud));
      },
    );
  });
}
