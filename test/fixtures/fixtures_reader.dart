import 'dart:io';

String fixture(String module, String name) =>
    File('./test/app/modules/$module/fixtures/$name.json').readAsStringSync();
