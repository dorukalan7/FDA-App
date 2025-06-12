DateTime parseCustomDate(String dateStr) {
  try {
    final parts = dateStr.split('/');
    if (parts.length == 3) {
      final month = int.parse(parts[0]);
      final day = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    }
  } catch (_) {}
  return DateTime(0);
}
