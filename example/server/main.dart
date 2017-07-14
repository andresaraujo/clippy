// Copyright (c) 2017, andres. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:clippy/server.dart' as clippy;

main(List<String> arguments) async {
  await clippy.write('https://github.com/andresaraujo/clippy');
  final clipboard = await clippy.read();

  print(clipboard);
}
