import 'package:flutter/material.dart';
import 'signal_ui.dart';

List<double> getSNRfromSF(int spreadingFactor) {
  switch (spreadingFactor) {
    case 7:
      return [4.0, -2.0, -4.0, -6.0];
    case 8:
      return [4.0, -4.0, -6.0, -8.0];
    case 9:
      return [4.0, -6.0, -8.0, -10.0];
    case 10:
      return [4.0, -8.0, -10.0, -13.0];
    case 11:
      return [4.0, -10.0, -12.5, -15.0];
    case 12:
      return [4.0, -12.5, -15.0, -18.0];
    default:
      return []; // Or throw Exception('Invalid SF: $spreadingFactor');
  }
}

class SNRIcon extends StatelessWidget {
  final double snr;
  final List<double> snrLevels;

  const SNRIcon({
    super.key,
    required this.snr,
    this.snrLevels = const [4.0, -2.0, -4.0, -6.0],
  });

  @override
  Widget build(BuildContext context) {
    final tier = snr >= snrLevels[0]
        ? 0
        : snr >= snrLevels[1]
        ? 1
        : snr >= snrLevels[2]
        ? 2
        : snr >= snrLevels[3]
        ? 3
        : 4;
    final signalUi = signalUiForStrengthTier(tier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(signalUi.icon, color: signalUi.color),
        Text('$snr dB', style: TextStyle(fontSize: 10, color: signalUi.color)),
      ],
    );
  }
}
