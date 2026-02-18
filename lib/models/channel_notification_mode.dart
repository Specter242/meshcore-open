enum ChannelNotificationMode { all, mentionsOnly, none }

ChannelNotificationMode channelNotificationModeFromInt(int? value) {
  return switch (value) {
    1 => ChannelNotificationMode.mentionsOnly,
    2 => ChannelNotificationMode.none,
    _ => ChannelNotificationMode.all,
  };
}

int channelNotificationModeToInt(ChannelNotificationMode mode) {
  return switch (mode) {
    ChannelNotificationMode.all => 0,
    ChannelNotificationMode.mentionsOnly => 1,
    ChannelNotificationMode.none => 2,
  };
}
