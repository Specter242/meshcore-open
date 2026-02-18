import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;

enum MessageScopeType { global, local, group }

class MessageScopeToken {
  final MessageScopeType type;
  final String rawToken;
  final String? groupName;

  const MessageScopeToken({
    required this.type,
    required this.rawToken,
    this.groupName,
  });
}

class MessageScopeHelper {
  static final RegExp _scopeRegex = RegExp(
    r'(^|\s)@(global|local|group:([A-Za-z0-9_-]{1,32}))(?=\s|$)',
    caseSensitive: false,
  );

  static MessageScopeToken? parseFirstScopeToken(String text) {
    final match = _scopeRegex.firstMatch(text);
    if (match == null) return null;

    final token = (match.group(2) ?? '').trim();
    if (token.isEmpty) return null;
    final lower = token.toLowerCase();

    if (lower == 'global') {
      return MessageScopeToken(type: MessageScopeType.global, rawToken: token);
    }
    if (lower == 'local') {
      return MessageScopeToken(type: MessageScopeType.local, rawToken: token);
    }
    if (lower.startsWith('group:')) {
      final group = token.substring('group:'.length).trim();
      if (group.isEmpty) return null;
      return MessageScopeToken(
        type: MessageScopeType.group,
        rawToken: token,
        groupName: group,
      );
    }
    return null;
  }

  static Uint8List? transportKeyForToken(MessageScopeToken token) {
    switch (token.type) {
      case MessageScopeType.global:
        return null;
      case MessageScopeType.local:
        return _transportKeyFromRegionName('local');
      case MessageScopeType.group:
        final group = token.groupName?.trim();
        if (group == null || group.isEmpty) return null;
        return _transportKeyFromRegionName(group);
    }
  }

  static Uint8List _transportKeyFromRegionName(String regionName) {
    final normalized = regionName.trim().toLowerCase();
    final scopeName = '#$normalized';
    final digest = crypto.sha256.convert(scopeName.codeUnits).bytes;
    return Uint8List.fromList(digest.sublist(0, 16));
  }

  static List<String> suggestionsForQuery(String query) {
    final q = query.toLowerCase();
    const all = <String>['@global', '@local', '@group:'];
    if (q.isEmpty || q == '@') return all;
    return all.where((entry) => entry.startsWith(q)).toList(growable: false);
  }
}
