extension StringX on String {
  String get svg => 'assets/svgs/$this.svg';
  String get pngImage => 'assets/images/$this.png';
  String get capitalizeFirst => isNotEmpty && [0].isNotEmpty
      ? '${this[0].toUpperCase()}${substring(1)}'
      : '';
  String get capitalize =>
      trim().split(' ').map((e) => e.capitalizeFirst).join(' ');
}
