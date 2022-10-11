import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/create.dart';

import 'create_test.mocks.dart';

@GenerateMocks([CrudRepository])
void main() {
  late Create sut;
  late MockCrudRepository mockCrudRepository;

  setUp(() {
    mockCrudRepository = MockCrudRepository();
    sut = Create(mockCrudRepository);
  });

  group("crud index usecase test", () {
    const Crud tNewCrud = Crud(name: "name", description: "description");
    const Crud tResponseCrud =
        Crud(id: 1, name: "name", description: "description");
    test(
      "shoud return a list of cruds from the repository",
      () async {
        when(mockCrudRepository.createCrud(any))
            .thenAnswer((_) async => const Right(tResponseCrud));

        final result = await sut(const CreateParams(crud: tNewCrud));

        expect(result, const Right(tResponseCrud));
        verify(mockCrudRepository.createCrud(tNewCrud));
      },
    );
  });
}
