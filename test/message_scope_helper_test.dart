import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/message_scope_helper.dart';

void main() {
  group('MessageScopeHelper', () {
    test('parses @global and maps to clear scope', () {
      final token = MessageScopeHelper.parseFirstScopeToken(
        'hello @global team',
      );
      expect(token, isNotNull);
      expect(token!.type, MessageScopeType.global);
      expect(MessageScopeHelper.transportKeyForToken(token), isNull);
    });

    test('parses @local and produces a 16-byte key', () {
      final token = MessageScopeHelper.parseFirstScopeToken('x @local y');
      expect(token, isNotNull);
      expect(token!.type, MessageScopeType.local);
      final key = MessageScopeHelper.transportKeyForToken(token);
      expect(key, isNotNull);
      expect(key!.length, 16);
    });

    test('parses @group:name and is case-insensitive', () {
      final token = MessageScopeHelper.parseFirstScopeToken(
        'Ping @GrOuP:US-CO',
      );
      expect(token, isNotNull);
      expect(token!.type, MessageScopeType.group);
      expect(token.groupName, 'US-CO');
      final key = MessageScopeHelper.transportKeyForToken(token);
      expect(key, isNotNull);
      expect(key!.length, 16);
    });

    test('provides suggestions for partial tokens', () {
      expect(MessageScopeHelper.suggestionsForQuery('@g'), contains('@global'));
      expect(MessageScopeHelper.suggestionsForQuery('@l'), contains('@local'));
      expect(
        MessageScopeHelper.suggestionsForQuery('@group'),
        contains('@group:'),
      );
    });
  });

  group('buildSetFloodScopeFrame', () {
    test('builds clear-scope frame with reserved byte', () {
      final frame = buildSetFloodScopeFrame();
      expect(frame.length, 2);
      expect(frame[0], cmdSetFloodScope);
      expect(frame[1], 0);
    });

    test('builds scoped frame with 16-byte key', () {
      final key = List<int>.generate(16, (i) => i + 1);
      final frame = buildSetFloodScopeFrame(
        transportKey: Uint8List.fromList(key),
      );
      expect(frame.length, 18);
      expect(frame[0], cmdSetFloodScope);
      expect(frame[1], 0);
      expect(frame.sublist(2), key);
    });
  });
}
