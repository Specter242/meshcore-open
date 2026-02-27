import 'dart:convert';
import 'dart:typed_data';

import '../models/contact.dart';
import 'prefs_manager.dart';

class DiscoveredNodeStore {
  static const String _key = 'discovered_nodes';

  Future<List<Contact>> loadNodes() async {
    final prefs = PrefsManager.instance;
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null) return [];

    try {
      final jsonList = jsonDecode(jsonStr) as List<dynamic>;
      return jsonList
          .map((entry) => _fromJson(entry as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveNodes(List<Contact> nodes) async {
    final prefs = PrefsManager.instance;
    final jsonList = nodes.map(_toJson).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  Map<String, dynamic> _toJson(Contact node) {
    return {
      'publicKey': base64Encode(node.publicKey),
      'name': node.name,
      'type': node.type,
      'flags': node.flags,
      'pathLength': node.pathLength,
      'path': base64Encode(node.path),
      'latitude': node.latitude,
      'longitude': node.longitude,
      'lastSeen': node.lastSeen.millisecondsSinceEpoch,
      'lastModified': node.lastModified.millisecondsSinceEpoch,
      'lastMessageAt': node.lastMessageAt.millisecondsSinceEpoch,
    };
  }

  Contact _fromJson(Map<String, dynamic> json) {
    final lastSeenMs = json['lastSeen'] as int? ?? 0;
    final lastModifiedMs = json['lastModified'] as int? ?? lastSeenMs;
    final lastMessageMs = json['lastMessageAt'] as int?;
    return Contact(
      publicKey: Uint8List.fromList(base64Decode(json['publicKey'] as String)),
      name: json['name'] as String? ?? 'Unknown',
      type: json['type'] as int? ?? 0,
      flags: json['flags'] as int? ?? 0,
      pathLength: json['pathLength'] as int? ?? -1,
      path: json['path'] != null
          ? Uint8List.fromList(base64Decode(json['path'] as String))
          : Uint8List(0),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(lastSeenMs),
      lastModified: DateTime.fromMillisecondsSinceEpoch(lastModifiedMs),
      lastMessageAt: DateTime.fromMillisecondsSinceEpoch(
        lastMessageMs ?? lastSeenMs,
      ),
    );
  }
}
