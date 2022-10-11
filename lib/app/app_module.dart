import 'package:flutter_modular/flutter_modular.dart';
import 'package:testing_modular/app/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/crud/crud_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NetworkInfoImpl(i())),
    Bind.lazySingleton((i) => SharedPreferences),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: CrudModule()),
  ];
}
