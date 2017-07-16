import 'dart:async';

abstract class Clipboard {
  Future<bool> write(input);
  Future<String> read();
}
