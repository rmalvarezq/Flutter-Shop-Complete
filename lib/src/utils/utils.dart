bool isNumeric(String s) {
  if (s.isEmpty) return false;
  // s.isEmpty ? false : true;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}
