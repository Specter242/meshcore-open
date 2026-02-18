import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/storage/discovered_node_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('DiscoveredNodeStore', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });

    test('saves and loads discovered nodes', () async {
      final store = DiscoveredNodeStore();
      final now = DateTime.now();
      final node = Contact(
        publicKey: Uint8List.fromList(
          List<int>.generate(32, (index) => index + 1),
        ),
        name: 'Node One',
        type: 1,
        flags: Contact.favoriteFlagMask,
        pathLength: 2,
        path: Uint8List.fromList([0xAA, 0xBB]),
        latitude: 12.34,
        longitude: 56.78,
        lastSeen: now,
      );

      await store.saveNodes([node]);
      final loaded = await store.loadNodes();

      expect(loaded.length, 1);
      expect(loaded.first.publicKeyHex, node.publicKeyHex);
      expect(loaded.first.name, 'Node One');
      expect(loaded.first.type, 1);
      expect(loaded.first.isFavorite, isTrue);
      expect(loaded.first.pathLength, 2);
      expect(loaded.first.path, Uint8List.fromList([0xAA, 0xBB]));
      expect(loaded.first.latitude, 12.34);
      expect(loaded.first.longitude, 56.78);
    });

    test('returns empty list for malformed storage payload', () async {
      final prefs = PrefsManager.instance;
      await prefs.setString('discovered_nodes', '{not json]');

      final store = DiscoveredNodeStore();
      final loaded = await store.loadNodes();

      expect(loaded, isEmpty);
    });
  });
}
