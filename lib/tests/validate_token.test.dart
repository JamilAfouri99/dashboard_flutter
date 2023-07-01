// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart' show expect, test;
import 'package:qcarder/helpers/token_validator.dart';

void main() {
  test('isTokenExpired should return true if token is expired', () {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoib3duZXItcWNhcmRlci5jb21AdGVzdC5jb20iLCJpYXQiOjE2ODczNzE2MzYsImV4cCI6MTY4NzM3MjUzNn0.BFpEidMRvK8Fe-rcu6aw2B4GEiIJHsFsrOHHLHUOlYw';

    expect(isTokenExpired(token), true);
  });

  test('isTokenExpired should return false if token is not expired', () {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoib3duZXItcWNhcmRlci5jb21AdGVzdC5jb20iLCJpYXQiOjE2ODczNzE2MzYsImV4cCI6MTY4NzM3MjUzNn0.BFpEidMRvK8Fe-rcu6aw2B4GEiIJHsFsrOHHLHUOlYw';

    expect(isTokenExpired(token), false);
  });
}
