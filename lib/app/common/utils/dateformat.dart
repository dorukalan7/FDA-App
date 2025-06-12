// lib/utils/utils.dart
String formatDate(String rawDate) {
  if (rawDate.length == 8) {
    return '${rawDate.substring(0, 4)}-${rawDate.substring(4, 6)}-${rawDate.substring(6, 8)}';
  }
  return rawDate;
}
