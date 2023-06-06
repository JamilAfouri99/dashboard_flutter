import 'package:dashboard/configuration/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  final String baseUrl;
  final Color color;
  final String title;

  Environment({
    required this.baseUrl,
    required this.color,
    required this.title,
  });

  factory Environment.development() {
    return Environment(
      baseUrl: dotenv.env['DEV_BASE_URL'] ?? '',
      color: AppColors.success,
      title: '(dev)',
    );
  }

  factory Environment.staging() {
    return Environment(
      baseUrl: dotenv.env['STAGING_BASE_URL']!,
      color: AppColors.background,
      title: '(staging)',
    );
  }

  factory Environment.production() {
    return Environment(
      baseUrl: dotenv.env['PRODUCTION_BASE_URL']!,
      color: AppColors.background,
      title: '',
    );
  }

  factory Environment.fromEnvironment(String environment) {
    switch (environment) {
      case 'development':
        return Environment.development();
      case 'production':
        return Environment.production();
      default:
        throw ArgumentError('Unknown environment: $environment');
    }
  }
}
