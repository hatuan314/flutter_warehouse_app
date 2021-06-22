extension StringExtensions on String {

  bool get isSafe => (this != null && this.isNotEmpty);

  bool get isNotSafe => (this == null || this.isEmpty);
}