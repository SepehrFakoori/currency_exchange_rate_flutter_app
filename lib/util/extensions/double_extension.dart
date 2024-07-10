extension DoubleFormatting on double {
  String doubleDigits() {
    if (this < 1 && this.toString().length > 5) {
      return this.toStringAsFixed(4);
    } else if (this >= 1) {
      return this.toStringAsFixed(2);
    } else {
      return this.toString();
    }
  }
}
