import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/modules/crud/domain/entities/crud_entity.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/show.dart';

import 'show_test.mocks.dart';

@GenerateMocks([CrudRepository])
void main() {
  late Show sut;
  late MockCrudRepository mockClirentRepository;

  setUp(() {
    mockClirentRepository = MockCrudRepository();
    sut = Show(mockClirentRepository);
  });

  group('crud show usecase test', () {
    const int tId = 1;
    const Crud tCrud = Crud(id: 1, name: "name", description: "description");

    test(
      "shuld return a crud from repository",
      () async {
        when(mockClirentRepository.showCrud(any))
            .thenAnswer((_) async => const Right(tCrud));

        final result = await sut(const ShowParams(id: tId));

        expect(result, const Right(tCrud));
        verify(mockClirentRepository.showCrud(tId));
      },
    );
  });
}
