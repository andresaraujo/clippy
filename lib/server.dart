import 'dart:async';
import 'dart:io' show Platform;

import 'package:clippy/src/clipboard.dart';
import 'package:clippy/src/server.dart';

Clipboard _platform() {
  if (Platform.isMacOS) {
    return new MacClipboard();
  } else {
    return new LinuxClipboard();
  }
}

Future<Null> write(String input) => _platform().write(input);
Future<String> read() => _platform().read();
