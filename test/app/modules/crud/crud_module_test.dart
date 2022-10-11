import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:modular_test/modular_test.dart';
import 'package:testing_modular/app/modules/crud/crud_module.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_local_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/external/datasource/crud_remote_data_source.dart';
import 'package:testing_modular/app/modules/crud/data/repositories/crud_repository_impl.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/create.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/delete.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/index.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/show.dart';
import 'package:testing_modular/app/modules/crud/domain/usecases/update.dart';
import 'package:testing_modular/app/modules/crud/presentation/bloc/crud_bloc.dart';

import 'crud_module_test.mocks.dart';

@GenerateMocks([
  IModularNavigator,
  CrudBloc,
  Update,
  Delete,
  Show,
  Index,
  Create,
  CrudRemoteDataSourceImpl,
  CrudLocalDataSourceImpl,
  CrudRepositoryImpl
])
void main() {
  late MockIModularNavigator mockIModularNavigator;
  late MockCrudBloc mockCrudBloc;
  late MockUpdate mockUpdate;
  late MockDelete mockDelete;
  late MockShow mockShow;
  late MockIndex mockIndex;
  late MockCreate mockCreate;
  late MockCrudRemoteDataSourceImpl mockCrudRemoteDataSourceImpl;
  late MockCrudLocalDataSourceImpl mockCrudLocalDataSourceImpl;
  late MockCrudRepositoryImpl mockCrudRepositoryImpl;

  setUp(() {
    mockIModularNavigator = MockIModularNavigator();
    mockCrudBloc = MockCrudBloc();
    mockUpdate = MockUpdate();
    mockDelete = MockDelete();
    mockShow = MockShow();
    mockIndex = MockIndex();
    mockCreate = MockCreate();
    mockCrudLocalDataSourceImpl = MockCrudLocalDataSourceImpl();
    mockCrudRemoteDataSourceImpl = MockCrudRemoteDataSourceImpl();
    mockCrudRepositoryImpl = MockCrudRepositoryImpl();

    Modular.navigatorDelegate = mockIModularNavigator;

    initModule(CrudModule(), replaceBinds: [
      Bind.instance<CrudBloc>(mockCrudBloc),
      Bind.instance<Update>(mockUpdate),
      Bind.instance<Delete>(mockDelete),
      Bind.instance<Show>(mockShow),
      Bind.instance<Index>(mockIndex),
      Bind.instance<Create>(mockCreate),
      Bind.instance<CrudLocalDataSourceImpl>(mockCrudLocalDataSourceImpl),
      Bind.instance<CrudRemoteDataSourceImpl>(mockCrudRemoteDataSourceImpl),
      Bind.instance<CrudRepositoryImpl>(mockCrudRepositoryImpl),
    ]);
  });

  //Todo: test crud module
}
