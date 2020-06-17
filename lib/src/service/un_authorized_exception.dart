class UnAuthorizedException implements Exception {
  String cause;

  UnAuthorizedException(this.cause);

  @override
  String toString() {
    return this.cause;
  }
}
