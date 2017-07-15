_**Clippy —** Access system clipboard in Dart (Server&Browser)_

[![Build Status](https://travis-ci.org/andresaraujo/clippy.svg?branch=master)](https://travis-ci.org/andresaraujo/clippy)
[![Build status](https://ci.appveyor.com/api/projects/status/ufiu8o0wvugr149b?svg=true)](https://ci.appveyor.com/project/andresaraujo/clippy)


A library to access the clipboard (copy/paste) for server and browser

### Install

Add `clippy` to dependencies/dev_dependencies in in your pubspec.yaml

### Usage

##### Server
In the server Clippy supports writing and reading from the clipboard. It uses system tools for this:
- On linux uses `xsel` (Install if needed)
- On Mac uses `pbcopy`/`pbpaste`
- On windows it embeds a copy/paste tool [win-clipboard](https://github.com/sindresorhus/win-clipboard)

```dart
import 'package:clippy/server.dart' as clippy;

main() async {
  // Write to clipboard
  await clippy.write('https://github.com/andresaraujo/clippy');
  
  // Read from clipboard
  final clipboard = await clippy.read();  
}
```

See [example](/example/server)

##### Browser

In the browser Clippy supports writing and listening to paste events.

```dart
import 'package:clippy/browser.dart' as clippy;

main() async {
  
  // Write a string to clipboard
  await clippy.write('https://github.com/andresaraujo/clippy');
  
  // Write text from an element to clipboard
  await clippy.write(element);
  
  // Write current selection to clipboard
  await clippy.write();
  
  // Listen to paste event
  clippy.onPaste.listen((text) => print('OnPaste: $text'));
  
}
```

See [example](/example/browser)

TODO:

- [ ] Test missing binary in linux
