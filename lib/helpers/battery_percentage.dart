int batteryPercentFromMillivolts(
  int millivolts, {
  int minMillivolts = 3000,
  int maxMillivolts = 4200,
}) {
  if (millivolts <= minMillivolts) return 0;
  if (millivolts >= maxMillivolts) return 100;

  return (((millivolts - minMillivolts) * 100) /
          (maxMillivolts - minMillivolts))
      .round();
}
