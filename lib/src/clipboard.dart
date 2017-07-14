import 'dart:async';

abstract class Clipboard {
  Future<Null> write(input);
  Future<String> read();
}
