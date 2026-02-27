import 'radio_settings.dart';

class CommunityRadioPreset {
  static const String regionAutoProfile = 'region_auto';
  static const String _communityPrefix = 'community:';

  final String id;
  final String name;
  final RadioSettings settings;

  const CommunityRadioPreset({
    required this.id,
    required this.name,
    required this.settings,
  });

  static final List<CommunityRadioPreset> all = [
    CommunityRadioPreset(
      id: 'australia',
      name: 'Australia',
      settings: RadioSettings(
        frequencyMHz: 915.800,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf10,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'australia_narrow',
      name: 'Australia (Narrow)',
      settings: RadioSettings(
        frequencyMHz: 916.575,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'australia_sa_wa',
      name: 'Australia: SA, WA',
      settings: RadioSettings(
        frequencyMHz: 923.125,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'australia_qld',
      name: 'Australia: QLD',
      settings: RadioSettings(
        frequencyMHz: 923.125,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'eu_uk_narrow',
      name: 'EU/UK (Narrow)',
      settings: RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'eu_uk_long_range',
      name: 'EU/UK (Long Range)',
      settings: RadioSettings(
        frequencyMHz: 869.525,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'eu_uk_medium_range',
      name: 'EU/UK (Medium Range)',
      settings: RadioSettings(
        frequencyMHz: 869.525,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf10,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'czech_narrow',
      name: 'Czech Republic (Narrow)',
      settings: RadioSettings(
        frequencyMHz: 869.432,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'eu_433_long_range',
      name: 'EU 433MHz (Long Range)',
      settings: RadioSettings(
        frequencyMHz: 433.650,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'new_zealand',
      name: 'New Zealand',
      settings: RadioSettings(
        frequencyMHz: 917.375,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'new_zealand_narrow',
      name: 'New Zealand (Narrow)',
      settings: RadioSettings(
        frequencyMHz: 917.375,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'portugal_433',
      name: 'Portugal 433',
      settings: RadioSettings(
        frequencyMHz: 433.375,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'portugal_868',
      name: 'Portugal 868',
      settings: RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'switzerland',
      name: 'Switzerland',
      settings: RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'usa_canada_recommended',
      name: 'USA/Canada (Recommended)',
      settings: RadioSettings(
        frequencyMHz: 910.525,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
    CommunityRadioPreset(
      id: 'vietnam',
      name: 'Vietnam',
      settings: RadioSettings(
        frequencyMHz: 920.250,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 22,
      ),
    ),
  ];

  String get profileValue => '$_communityPrefix$id';

  static bool isKnownProfile(String profile) {
    if (profile == regionAutoProfile) return true;
    return fromProfile(profile) != null;
  }

  static CommunityRadioPreset? fromProfile(String profile) {
    if (!profile.startsWith(_communityPrefix)) return null;
    final id = profile.substring(_communityPrefix.length);
    for (final preset in all) {
      if (preset.id == id) return preset;
    }
    return null;
  }

  static RadioSettings resolveProfileSettings(
    String profile, {
    String? countryCode,
    String? languageCode,
  }) {
    final explicit = fromProfile(profile);
    if (explicit != null) return explicit.settings;

    // Backward compatibility for older saved default profile values.
    switch (profile) {
      case 'repeater_default':
        return RadioSettings(
          frequencyMHz: 869.525,
          bandwidth: LoRaBandwidth.bw250,
          spreadingFactor: LoRaSpreadingFactor.sf11,
          codingRate: LoRaCodingRate.cr4_5,
          txPowerDbm: 22,
        );
      case '915mhz':
        return RadioSettings(
          frequencyMHz: 915.0,
          bandwidth: LoRaBandwidth.bw125,
          spreadingFactor: LoRaSpreadingFactor.sf7,
          codingRate: LoRaCodingRate.cr4_5,
          txPowerDbm: 20,
        );
      case '868mhz':
        return RadioSettings(
          frequencyMHz: 868.0,
          bandwidth: LoRaBandwidth.bw125,
          spreadingFactor: LoRaSpreadingFactor.sf7,
          codingRate: LoRaCodingRate.cr4_5,
          txPowerDbm: 14,
        );
      case '433mhz':
        return RadioSettings(
          frequencyMHz: 433.0,
          bandwidth: LoRaBandwidth.bw125,
          spreadingFactor: LoRaSpreadingFactor.sf7,
          codingRate: LoRaCodingRate.cr4_5,
          txPowerDbm: 20,
        );
      case 'long_range':
        return RadioSettings(
          frequencyMHz: 915.0,
          bandwidth: LoRaBandwidth.bw125,
          spreadingFactor: LoRaSpreadingFactor.sf12,
          codingRate: LoRaCodingRate.cr4_8,
          txPowerDbm: 20,
        );
      case 'fast_speed':
        return RadioSettings(
          frequencyMHz: 915.0,
          bandwidth: LoRaBandwidth.bw500,
          spreadingFactor: LoRaSpreadingFactor.sf7,
          codingRate: LoRaCodingRate.cr4_5,
          txPowerDbm: 20,
        );
      case regionAutoProfile:
      default:
        return _resolveRegionAuto(
          countryCode: countryCode,
          languageCode: languageCode,
        );
    }
  }

  static RadioSettings _resolveRegionAuto({
    String? countryCode,
    String? languageCode,
  }) {
    final country = countryCode?.toUpperCase();
    if (country != null) {
      if (_euCountries.contains(country)) {
        return all.firstWhere((p) => p.id == 'eu_uk_narrow').settings;
      }
      if (country == 'CH') {
        return all.firstWhere((p) => p.id == 'switzerland').settings;
      }
      if (country == 'CZ') {
        return all.firstWhere((p) => p.id == 'czech_narrow').settings;
      }
      if (country == 'PT') {
        return all.firstWhere((p) => p.id == 'portugal_868').settings;
      }
      if (country == 'AU') {
        return all.firstWhere((p) => p.id == 'australia_narrow').settings;
      }
      if (country == 'NZ') {
        return all.firstWhere((p) => p.id == 'new_zealand_narrow').settings;
      }
      if (country == 'VN') {
        return all.firstWhere((p) => p.id == 'vietnam').settings;
      }
      if (country == 'US' || country == 'CA') {
        return all.firstWhere((p) => p.id == 'usa_canada_recommended').settings;
      }
    }

    final language = languageCode?.toLowerCase();
    if (language != null && _likelyEuLanguages.contains(language)) {
      return all.firstWhere((p) => p.id == 'eu_uk_narrow').settings;
    }
    return all.firstWhere((p) => p.id == 'usa_canada_recommended').settings;
  }

  static const Set<String> _likelyEuLanguages = {
    'bg',
    'cs',
    'de',
    'es',
    'fr',
    'it',
    'nl',
    'pl',
    'pt',
    'ru',
    'sk',
    'sl',
    'sv',
    'uk',
  };

  static const Set<String> _euCountries = {
    'AT',
    'BE',
    'BG',
    'CY',
    'DE',
    'DK',
    'EE',
    'ES',
    'FI',
    'FR',
    'GB',
    'GR',
    'HR',
    'HU',
    'IE',
    'IS',
    'IT',
    'LT',
    'LU',
    'LV',
    'MT',
    'NL',
    'NO',
    'PL',
    'PT',
    'RO',
    'SE',
    'SI',
    'SK',
  };
}
