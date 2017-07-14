import 'package:clippy/server.dart' as clippy;

main() async {
  await clippy.write('https://github.com/andresaraujo/clippy');
  final clipboard = await clippy.read();

  print(clipboard);
}
