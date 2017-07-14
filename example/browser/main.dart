import 'dart:html';
import 'package:clippy/browser.dart' as clippy;

main() {
  final copyTextBtn = document.querySelector('.copy-text-btn');

  final copyElementBtn = document.querySelector('.copy-element-btn');
  final copyElementTarget = document.querySelector('.copy-element-target');

  copyTextBtn.onClick.listen((_) {
    clippy.write(new DateTime.now().toIso8601String());
    addAction('Copy: from plain text');
  });
  copyElementBtn.onClick.listen((_) {
    clippy.write(copyElementTarget);
    addAction('Copy: from element');
  });

  clippy.onPaste.listen((text) => addAction('OnPaste: $text'));
}

addAction(text) {
  final ul = document.querySelector('.actions');

  ul.children.add(new LIElement()..text = text);
}
