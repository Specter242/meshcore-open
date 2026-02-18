import '../models/channel_notification_mode.dart';
import 'prefs_manager.dart';

class ChannelSettingsStore {
  static const String _smazKeyPrefix = 'channel_smaz_';
  static const String _notificationModeKeyPrefix = 'channel_notify_mode_';

  Future<bool> loadSmazEnabled(int channelIndex) async {
    final prefs = PrefsManager.instance;
    final key = '$_smazKeyPrefix$channelIndex';
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveSmazEnabled(int channelIndex, bool enabled) async {
    final prefs = PrefsManager.instance;
    final key = '$_smazKeyPrefix$channelIndex';
    await prefs.setBool(key, enabled);
  }

  Future<ChannelNotificationMode> loadNotificationMode(int channelIndex) async {
    final prefs = PrefsManager.instance;
    final key = '$_notificationModeKeyPrefix$channelIndex';
    final raw = prefs.getInt(key);
    return channelNotificationModeFromInt(raw);
  }

  Future<void> saveNotificationMode(
    int channelIndex,
    ChannelNotificationMode mode,
  ) async {
    final prefs = PrefsManager.instance;
    final key = '$_notificationModeKeyPrefix$channelIndex';
    await prefs.setInt(key, channelNotificationModeToInt(mode));
  }
}
