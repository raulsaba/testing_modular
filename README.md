# testing_modular

A project created to pratice and test Flutter Modular from flutterando using blocs and a basic crud app.
https://pub.dev/packages/flutter_modular
https://modular.flutterando.com.br/

Flutter version: 3.3.3
Slidy version: 4.0.3
fvm version: 2.4.1
flutter_modular version: 5.0.3

# using fvm

generate the folder .fvm using the required flutter version

e.g. 
```
fvm use stable
```
```
fvm use 3.3.3
```

# VS Code configuration to use fvm

e.g. of .vscode/settings.json

```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk",
  // Remove .fvm files from search
  "search.exclude": {
    "**/.fvm": true
  },
  // Remove from file watching
  "files.watcherExclude": {
    "**/.fvm": true
  }
}
```
