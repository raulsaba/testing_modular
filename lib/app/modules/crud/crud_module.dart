import 'package:flutter_modular/flutter_modular.dart';
import 'package:testing_modular/app/modules/crud/data/repositories/crud_repository_impl.dart';

import 'data/external/datasource/crud_local_data_source.dart';
import 'data/external/datasource/crud_remote_data_source.dart';
import 'domain/usecases/create.dart';
import 'domain/usecases/delete.dart';
import 'domain/usecases/index.dart';
import 'domain/usecases/show.dart';
import 'domain/usecases/update.dart';
import 'presentation/bloc/crud_bloc.dart';
import 'presentation/pages/crud_page.dart';

class CrudModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CrudBloc()),
    Bind.lazySingleton((i) => Update(i())),
    Bind.lazySingleton((i) => Delete(i())),
    Bind.lazySingleton((i) => Index(i())),
    Bind.lazySingleton((i) => Show(i())),
    Bind.lazySingleton((i) => Create(i())),
    Bind.lazySingleton((i) => CrudRemoteDataSourceImpl(i(), i())),
    Bind.lazySingleton((i) => CrudLocalDataSourceImpl(i())),
    Bind.lazySingleton((i) => CrudRepositoryImpl(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const CrudPage()),
  ];
}
