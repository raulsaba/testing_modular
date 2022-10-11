import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_modular/app/modules/crud/domain/repositories/crud_repository.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/delete.dart';

import 'delete_test.mocks.dart';

@GenerateMocks([CrudRepository])
void main() {
  late Delete sut;
  late MockCrudRepository mockCrudRepository;

  setUp(() {
    mockCrudRepository = MockCrudRepository();
    sut = Delete(mockCrudRepository);
  });

  group("crud index usecase test", () {
    const int tId = 1;
    const bool tResponse = true;
    test(
      "shoud return a list of cruds from the repository",
      () async {
        when(mockCrudRepository.deleteCrud(any))
            .thenAnswer((_) async => const Right(tResponse));

        final result = await sut(const DeleteParams(id: tId));

        expect(result, const Right(tResponse));
        verify(mockCrudRepository.deleteCrud(tId));
      },
    );
  });
}
