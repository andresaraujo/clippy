import 'dart:async';

import 'package:clippy/src/clipboard.dart';
import 'package:clippy/src/server.dart';

Clipboard _platform() {
  return new MacClipboard();
}

Future<Null> write(String input) => _platform().write(input);
Future<String> read() => _platform().read();
