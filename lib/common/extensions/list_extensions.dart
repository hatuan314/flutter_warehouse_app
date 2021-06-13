extension ListExtensions on List {
  bool get isSafe {
    if (this != null && this.isNotEmpty)
      return true;
    return false;
  }

  bool get isNotSafe {
    if (this == null || this.isEmpty)
      return true;
    return false;
  }
}