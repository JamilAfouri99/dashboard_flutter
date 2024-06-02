import 'dart:math';

String generateSimpleId() {
  int randomNumber = Random().nextInt(1000000);
  String id = randomNumber.toString();

  return id;
}
