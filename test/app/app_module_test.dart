import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:modular_test/modular_test.dart';
import 'package:testing_modular/app/app_module.dart';
import 'package:testing_modular/app/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_module_test.mocks.dart';

@GenerateMocks([
  IModularNavigator,
  NetworkInfoImpl,
  SharedPreferences,
])
void main() {
  late MockIModularNavigator mockIModularNavigator;
  late MockNetworkInfoImpl mockNetworkInfoImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockIModularNavigator = MockIModularNavigator();
    mockNetworkInfoImpl = MockNetworkInfoImpl();
    mockSharedPreferences = MockSharedPreferences();

    Modular.navigatorDelegate = mockIModularNavigator;

    initModule(AppModule(), replaceBinds: [
      Bind.instance<NetworkInfoImpl>(mockNetworkInfoImpl),
      Bind.instance<SharedPreferences>(mockSharedPreferences),
    ]);
  });

  //todo: test app module
}
