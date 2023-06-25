class Result<T> {
  final T? value;
  final dynamic error;

  Result.ok(this.value) : error = null;
  Result.err(this.error) : value = null;

  bool get isSuccess => value != null;
  bool get isError => error != null;
}
