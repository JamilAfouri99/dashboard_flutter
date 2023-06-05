class Result<T> {
  final T? value;
  final dynamic error;

  Result.ok(this.value) : error = null;
  Result.err(this.error) : value = null;

  bool get isSuccess => value != null;
  bool get isError => error != null;
}

class ResultHandler {
  static Result<T> tryCatch<T>(T Function() action) {
    try {
      final result = action();
      return Result.ok(result);
    } catch (error) {
      return Result.err(error);
    }
  }

  static Future<Result<T>> asyncTryCatch<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Result.ok(result);
    } catch (error) {
      return Result.err(error);
    }
  }
}
