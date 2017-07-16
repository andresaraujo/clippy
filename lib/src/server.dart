import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:clippy/src/clipboard.dart';

class MacClipboard implements Clipboard {
  @override
  Future<bool> write(covariant String input) async {
    final process = await Process.start('pbcopy', [], runInShell: true);
    process.stderr.transform(UTF8.decoder).listen(print);
    process.stdin.write(input);

    try {
      await process.stdin.close();
    } catch (e) {
      return false;
    }

    return await process.exitCode == 0;
  }

  @override
  Future<String> read() async {
    final process = await Process.start('pbpaste', [], runInShell: true);
    process.stderr.transform(UTF8.decoder).listen(print);

    final stdout = process.stdout.transform(UTF8.decoder);

    try {
      return await stdout.first;
    } catch (_) {
      return '';
    }
  }
}

class LinuxClipboard implements Clipboard {
  @override
  Future<bool> write(covariant String input) async {
    final process = await Process.start('xsel', ['--clipboard', '--input'],
        runInShell: true);
    process.stderr.transform(UTF8.decoder).listen(print);
    process.stdin.write(input);

    try {
      await process.stdin.close();
    } catch (e) {
      print(
          'Clippy needs [xsel] in Linux, please install it. Nothing was written to clipboard');
      return false;
    }

    return await process.exitCode == 0;
  }

  @override
  Future<String> read() async {
    final process = await Process.start('xsel', ['--clipboard', '--output'],
        runInShell: true);
    process.stderr.transform(UTF8.decoder).listen(print);

    final stdout = process.stdout.transform(UTF8.decoder);

    try {
      return await stdout.first;
    } catch (_) {
      return '';
    }
  }
}

final winCopyPath = path.join(path.current, 'lib/src/backends/windows/copy.exe');
final winPastePath = path.join(path.current, 'lib/src/backends/windows/paste.exe');

class WindowsClipboard implements Clipboard {
  @override
  Future<bool> write(covariant String input) async {
    final process = await Process.start(winCopyPath, [], runInShell: true);
    process.stderr.transform(UTF8.decoder).listen(print);
    process.stdin.write(input);

    try {
      await process.stdin.close();
    } catch (e) {
      print(
          'Clippy needs [xsel] in Linux, please install it. Nothing was written to clipboard');
      return false;
    }

    return await process.exitCode == 0;
  }

  @override
  Future<String> read() async {
    final process = await Process.start(winPastePath, [], runInShell: true);
    process.stderr.transform(UTF8.decoder).listen(print);

    final stdout = process.stdout.transform(UTF8.decoder);

    try {
      return await stdout.first;
    } catch (_) {
      return '';
    }
  }
}
