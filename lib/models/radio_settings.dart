enum LoRaBandwidth {
  bw7_8(7800, '7.8 kHz'),
  bw10_4(10400, '10.4 kHz'),
  bw15_6(15600, '15.6 kHz'),
  bw20_8(20800, '20.8 kHz'),
  bw31_25(31250, '31.25 kHz'),
  bw41_7(41700, '41.7 kHz'),
  bw62_5(62500, '62.5 kHz'),
  bw125(125000, '125 kHz'),
  bw250(250000, '250 kHz'),
  bw500(500000, '500 kHz');

  final int hz;
  final String label;

  const LoRaBandwidth(this.hz, this.label);
}

enum LoRaSpreadingFactor {
  sf5(5, 'SF5'),
  sf6(6, 'SF6'),
  sf7(7, 'SF7'),
  sf8(8, 'SF8'),
  sf9(9, 'SF9'),
  sf10(10, 'SF10'),
  sf11(11, 'SF11'),
  sf12(12, 'SF12');

  final int value;
  final String label;

  const LoRaSpreadingFactor(this.value, this.label);
}

enum LoRaCodingRate {
  cr4_5(5, '4/5'),
  cr4_6(6, '4/6'),
  cr4_7(7, '4/7'),
  cr4_8(8, '4/8');

  final int value;
  final String label;

  const LoRaCodingRate(this.value, this.label);
}

class RadioDefaultProfile {
  static const String regionAuto = 'region_auto';
  static const String repeaterDefault = 'repeater_default';
  static const String preset915MHz = '915mhz';
  static const String preset868MHz = '868mhz';
  static const String preset433MHz = '433mhz';
  static const String longRange = 'long_range';
  static const String fastSpeed = 'fast_speed';

  static const List<String> values = [
    regionAuto,
    repeaterDefault,
    preset915MHz,
    preset868MHz,
    preset433MHz,
    longRange,
    fastSpeed,
  ];
}

class RadioSettings {
  final double frequencyMHz;
  final LoRaBandwidth bandwidth;
  final LoRaSpreadingFactor spreadingFactor;
  final LoRaCodingRate codingRate;
  final int txPowerDbm;

  RadioSettings({
    required this.frequencyMHz,
    required this.bandwidth,
    required this.spreadingFactor,
    required this.codingRate,
    required this.txPowerDbm,
  });

  // Preset configurations
  static RadioSettings get preset915MHz => RadioSettings(
    frequencyMHz: 915.0,
    bandwidth: LoRaBandwidth.bw125,
    spreadingFactor: LoRaSpreadingFactor.sf7,
    codingRate: LoRaCodingRate.cr4_5,
    txPowerDbm: 20,
  );

  static RadioSettings get preset868MHz => RadioSettings(
    frequencyMHz: 868.0,
    bandwidth: LoRaBandwidth.bw125,
    spreadingFactor: LoRaSpreadingFactor.sf7,
    codingRate: LoRaCodingRate.cr4_5,
    txPowerDbm: 14,
  );

  static RadioSettings get preset433MHz => RadioSettings(
    frequencyMHz: 433.0,
    bandwidth: LoRaBandwidth.bw125,
    spreadingFactor: LoRaSpreadingFactor.sf7,
    codingRate: LoRaCodingRate.cr4_5,
    txPowerDbm: 20,
  );

  static RadioSettings get presetLongRange => RadioSettings(
    frequencyMHz: 915.0,
    bandwidth: LoRaBandwidth.bw125,
    spreadingFactor: LoRaSpreadingFactor.sf12,
    codingRate: LoRaCodingRate.cr4_8,
    txPowerDbm: 20,
  );

  static RadioSettings get presetFastSpeed => RadioSettings(
    frequencyMHz: 915.0,
    bandwidth: LoRaBandwidth.bw500,
    spreadingFactor: LoRaSpreadingFactor.sf7,
    codingRate: LoRaCodingRate.cr4_5,
    txPowerDbm: 20,
  );

  // Matches MeshCore repeater software documented default radio plan.
  static RadioSettings get presetRepeaterDefault => RadioSettings(
    frequencyMHz: 869.525,
    bandwidth: LoRaBandwidth.bw250,
    spreadingFactor: LoRaSpreadingFactor.sf11,
    codingRate: LoRaCodingRate.cr4_5,
    txPowerDbm: 20,
  );

  static RadioSettings fromDefaultProfile(
    String profile, {
    String? countryCode,
    String? languageCode,
  }) {
    switch (profile) {
      case RadioDefaultProfile.preset915MHz:
        return preset915MHz;
      case RadioDefaultProfile.repeaterDefault:
        return presetRepeaterDefault;
      case RadioDefaultProfile.preset868MHz:
        return preset868MHz;
      case RadioDefaultProfile.preset433MHz:
        return preset433MHz;
      case RadioDefaultProfile.longRange:
        return presetLongRange;
      case RadioDefaultProfile.fastSpeed:
        return presetFastSpeed;
      case RadioDefaultProfile.regionAuto:
      default:
        return fromRegion(countryCode: countryCode, languageCode: languageCode);
    }
  }

  static RadioSettings fromRegion({String? countryCode, String? languageCode}) {
    final country = countryCode?.toUpperCase();
    if (country != null) {
      if (_regions915.contains(country)) return preset915MHz;
      if (_regions868.contains(country)) return preset868MHz;
      if (_regions433.contains(country)) return preset433MHz;
    }

    // Fallback by language when country code is unavailable.
    final language = languageCode?.toLowerCase();
    if (language != null && _languagesLikely868.contains(language)) {
      return preset868MHz;
    }
    return preset915MHz;
  }

  static const Set<String> _regions915 = {
    'US',
    'CA',
    'AU',
    'NZ',
    'MX',
    'AR',
    'BR',
    'CL',
    'CO',
    'PE',
  };

  static const Set<String> _regions868 = {
    'AT',
    'BE',
    'BG',
    'CH',
    'CY',
    'CZ',
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

  static const Set<String> _regions433 = {'IN'};

  static const Set<String> _languagesLikely868 = {
    'bg',
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

  int get frequencyHz => (frequencyMHz * 1000).round();
  int get bandwidthHz => bandwidth.hz;
  int get sf => spreadingFactor.value;
  int get cr => codingRate.value;
}
