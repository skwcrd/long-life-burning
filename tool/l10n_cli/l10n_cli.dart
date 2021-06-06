import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

const _l10nDir = 'lib/l10n';
const _intlHeader = '''
<?xml version="1.0" encoding="utf-8"?>
<!--
  This file was automatically generated.
  Please do not edit it manually.
  It is based on lib/l10n/intl_en.arb.
-->
<resources>
''';

const _pluralSuffixes = <String>[
  'Zero',
  'One',
  'Two',
  'Few',
  'Many',
  'Other',
];

String _escapeXml(String xml) =>
    xml
      .replaceAll('&', '&amp;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;')
      .replaceAll('>', '&gt;')
      .replaceAll('<', '&lt;');

/// Processes the XML files.
///
/// Note that the filename for `intl_en_US.xml` is used by the internal
/// translation console and changing the filename may require manually updating
/// already translated messages to point to the new file. Therefore, avoid doing so
/// unless necessary.
Future<void> englishArbsToXmls({bool isDryRun = false}) async {
  final output =
      isDryRun ? stdout : File('$_l10nDir/intl_en_US.xml').openWrite();
  await generateXmlFromArb(
    inputArb: File('$_l10nDir/intl_en.arb'),
    outputXml: output,
    xmlHeader: _intlHeader,
  );
  await output.close();
}

@visibleForTesting
Future<void> generateXmlFromArb({
  required File inputArb,
  required IOSink outputXml,
  required String xmlHeader,
}) async {
  final bundle =
      jsonDecode(await inputArb.readAsString()) as Map<String, dynamic>;

  String translationFor(String key) {
    // ignore: prefer_asserts_with_message
    assert(bundle[key] != null);
    return _escapeXml(bundle[key].toString());
  }

  final xml = StringBuffer(xmlHeader);

  for ( final key in bundle.keys ) {
    if ( key == '@@last_modified' ) {
      continue;
    }

    if ( !key.startsWith('@') ) {
      continue;
    }

    final resourceId = key.substring(1);
    final name = _escapeXml(resourceId);
    final metaInfo = bundle[key] as Map<String, dynamic>;

    // ignore: prefer_asserts_with_message
    assert(metaInfo['description'] != null);
    var description = _escapeXml(metaInfo['description'].toString());

    if ( metaInfo.containsKey('plural') ) {
      // Generate a plurals resource element formatted like this:
      // <plurals
      //   name="dartVariableName"
      //   description="description">
      //   <item
      //     quantity="other"
      //     >%d translation</item>
      //   ... items for quantities one, two, etc.
      // </plurals>
      final quantityVar = "\$${metaInfo['plural']}";

      description = description.replaceAll('\$$quantityVar', '%d');

      xml.writeln(
        '  <plurals name="$name" description="$description">');

      for ( final suffix in _pluralSuffixes ) {
        final pluralKey = '$resourceId$suffix';

        if ( bundle.containsKey(pluralKey) ) {
          final translation =
              translationFor(pluralKey).replaceFirst(quantityVar, '%d');

          xml.writeln(
            '    <item quantity="${suffix.toLowerCase()}">$translation</item>');
        }
      }
      xml.writeln('  </plurals>');
    } else if (metaInfo.containsKey('parameters')) {
      // Generate a parameterized string resource element formatted like this:
      // <string
      //   name="dartVariableName"
      //   description="string description"
      //   >string %1$s %2$s translation</string>
      // The translated string's original $vars, which must be listed in its
      // description's 'parameters' value, are replaced with printf positional
      // string arguments, like "%1$s".
      var translation = translationFor(resourceId);
      // ignore: prefer_asserts_with_message
      assert((metaInfo['parameters'] as String).trim().isNotEmpty);
      final parameters = (metaInfo['parameters'] as String)
          .split(',')
          .map<String>((s) => s.trim())
          .toList();
      var index = 1;
      for (final parameter in parameters) {
        translation = translation.replaceAll('\$$parameter', '%$index\$s');
        description = description.replaceAll('\$$parameter', '%$index\$s');
        index += 1;
      }
      xml.writeln(
        '  <string name="$name" description="$description">$translation</string>');
    } else {
      // Generate a string resource element formatted like this:
      // <string
      //   name="dartVariableName"
      //   description="string description"
      //   >string translation</string>
      final translation = translationFor(resourceId);
      xml.writeln(
        '  <string name="$name" description="$description">$translation</string>');
    }
  }
  xml.writeln('</resources>');
  outputXml.write(xml.toString());
}