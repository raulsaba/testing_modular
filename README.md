# testing_modular

Flutter Version: 3.3.3

# fvm

generate the folder .fvm using the required flutter version

e.g. 
-> fvm use stable
-> fvm use 3.3.3


# VS Code configuration to use fvm

e.g. of .vscode/settings.json

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
