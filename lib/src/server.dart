import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clippy/src/clipboard.dart';

class MacClipboard implements Clipboard {
  @override
  Future<Null> write(covariant String input) async {
    final process = await Process.start('pbcopy', [], runInShell: true);
    process.stdin.write(input);
    process.stdin.close();
  }

  @override
  Future<String> read() async {
    final process = await Process.start('pbpaste', [], runInShell: true);

    return await process.stdout.transform(UTF8.decoder).first;
  }
}

class LinuxClipboard implements Clipboard {
  @override
  Future<Null> write(covariant String input) async {
    try {
      final process = await Process.start('xsel', ['--clipboard', '--input'],
          runInShell: true);
      process.stdin.write(input);
      process.stdin.close();
    } catch (e) {
      print(
          'Clippy needs [xsel] in Linux, please install it. Nothing was written to clipboard');
    }
  }

  @override
  Future<String> read() async {
    final process = await Process.start('xsel', ['--clipboard', '--output'],
        runInShell: true);

    return await process.stdout.transform(UTF8.decoder).first;
  }
}
