// Copyright (c) 2017, andres. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:clippy/server.dart' as clippy;
import 'package:test/test.dart';

void main() {
  test('Writes and reads to clipboard', () async {
    final expected = '123456789abcdefghijklmnopqrstuvwxyz+-=&_[]<^=>=/{:})-{(`)}';
    await clippy.write(expected);
    final clipboard = await clippy.read();
    expect(clipboard, expected);
  });
}
