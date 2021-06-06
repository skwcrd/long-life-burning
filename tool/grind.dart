import 'dart:async';
import 'dart:io';

import 'package:grinder/grinder.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) => grind(args);

@Task('Get packages')
Future<void> pubGet({ String? directory }) async {
  await _runProcess(
    'flutter',
    ['pub', 'get', if ( directory != null ) directory],
  );
}

@Task('Format dart files')
Future<void> format({String path = '.'}) async {
  await _runProcess('flutter', ['format', path]);
}

@Task('Transform arb to xml for English')
Future<void> l10n() async {
  final l10nPath =
      path.join(Directory.current.path, 'tool', 'l10n_cli', 'main.dart');
  Dart.run(l10nPath);
}

@Task('Verify xml localizations')
Future<void> verifyL10n() async {
  final l10nPath =
      path.join(Directory.current.path, 'tool', 'l10n_cli', 'main.dart');

  // Run the tool to transform arb to xml, and write the output to stdout.
  final xmlOutput = Dart.run(l10nPath, arguments: ['--dry-run'], quiet: true);

  // Read the original xml file.
  final xmlPath =
      path.join(Directory.current.path, 'lib', 'l10n', 'intl_en_US.xml');
  final expectedXmlOutput = await File(xmlPath).readAsString();

  if (xmlOutput.trim() != expectedXmlOutput.trim()) {
    stderr.writeln(
      'The contents of $xmlPath are different from that produced by '
      'l10n_cli. Did you forget to run `flutter pub run grinder '
      'l10n` after updating an .arb file?',
    );
    exit(1);
  }
}

Future<void> _runProcess(String executable, List<String> arguments) async {
  final result = await Process.run(executable, arguments);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}