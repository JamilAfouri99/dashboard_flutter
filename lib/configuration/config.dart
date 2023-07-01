import 'package:qcarder/models/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static final _instance = EnvConfig._();

  static EnvConfig get instance => _instance;

  late final String baseUrl;
  late final Color color;
  late final String title;

  EnvConfig._() {
    final env = Environment.fromEnvironment(dotenv.env['ENV'] ?? '');
    baseUrl = env.baseUrl;
    color = env.color;
    title = env.title;
  }
}
