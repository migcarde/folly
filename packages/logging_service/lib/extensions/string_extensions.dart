extension StringExtensions on String {
  String get logTitle => '/// $this ///';
  String get removeLineBreaks => replaceAll(RegExp(r'[\r\n]+'), '');
}
