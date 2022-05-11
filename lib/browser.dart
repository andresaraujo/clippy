import 'dart:async';
import 'dart:html';
import 'package:clippy/src/browser.dart';

final clipboard = new BrowserClipboard();

Future<bool> write([input]) async {
  if (input is Element) {
    return await clipboard.write(input);
  } else if (input is String) {
    return await _writeText(input) ?? false;
  } else {
    return await clipboard.write();
  }
}

Stream<String> get onPaste => clipboard.onPaste;

Future<Null> _writeText(String text) async {
  final element = _createFakeElement(text);
  document.body?.children.add(element);
  await clipboard.write(element);
  document.body?.children.remove(element);
}

TextAreaElement _createFakeElement(String text) {
  final isRtl = document.documentElement?.getAttribute('dir') == 'rtl';
  final fakeElem = new TextAreaElement();

  // Prevent zooming on iOS
  fakeElem.style.fontSize = '12pt';
  // Reset box model
  fakeElem.style.border = '0';
  fakeElem.style.padding = '0';
  fakeElem.style.margin = '0';

  // Move element out of screen horizontally
  fakeElem.style.position = 'absolute';
  if (isRtl) {
    fakeElem.style.right = '-9999px';
  } else {
    fakeElem.style.left = '-9999px';
  }
  // Move element to the same position vertically
  final yPosition = window.pageYOffset;
  fakeElem.style.top = '${yPosition}px';

  fakeElem.setAttribute('readonly', '');
  fakeElem.value = text;

  return fakeElem;
}
