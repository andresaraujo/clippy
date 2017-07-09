import 'dart:async';
import 'dart:html';

import 'package:clippy/src/clipboard.dart';

class BrowserClipboard  implements Clipboard {
  @override
  Future<Null> write([covariant Element element]) async {
    if(element != null) {
      selectText(element);
    }
    document.execCommand('copy');

    if(element != null) {
      window.getSelection().removeAllRanges();
    }
  }

  @override
  Future<String> read() async {
    // TODO: not supported by browsers
    return '';
  }

  Stream<String> get onPaste => document.onPaste.map(_textConverter);
}

String _textConverter(ClipboardEvent input) {
  return input.clipboardData.getData('text/plain');
}

selectText(Element element) {
  var selectedText = '';

  if (element is SelectElement) {

    element.focus();
    selectedText = element.value;

  } else if (element is InputElement) {

    final isReadOnly = element.getAttribute('readonly') != null;

    if (!isReadOnly) {
      element.setAttribute('readonly', '');
    }

    element.select();
    element.setSelectionRange(0, element.value.length);

    if (!isReadOnly) {
      element.attributes.remove('readonly');
    }

    selectedText = element.value;

  } else if (element is TextAreaElement) {

    final isReadOnly = element.getAttribute('readonly') != null;

    if (!isReadOnly) {
      element.setAttribute('readonly', '');
    }

    element.select();
    element.setSelectionRange(0, element.value.length);

    if (!isReadOnly) {
      element.attributes.remove('readonly');
    }

    selectedText = element.value;

  } else {

    if (element.getAttribute('contenteditable') != null) {
      element.focus();
    }

    var selection = window.getSelection();
    var range = document.createRange();

    range.selectNodeContents(element);
    selection.removeAllRanges();
    selection.addRange(range);

    selectedText = selection.toString();
  }

  return selectedText;
}