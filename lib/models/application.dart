import 'dart:ui';

import 'job.dart';
import 'ats_score.dart';

enum ApplicationStatus { applied, underReview, shortlisted, rejected, selected }

class Application {
  final String id;
  final Job job;
  final DateTime appliedDate;
  final ApplicationStatus status;
  final ATSScore atsScore;
  final String? statusMessage;

  Application({
    required this.id,
    required this.job,
    required this.appliedDate,
    required this.status,
    required this.atsScore,
    this.statusMessage,
  });

  String get statusText {
    switch (status) {
      case ApplicationStatus.applied:
        return 'Applied';
      case ApplicationStatus.underReview:
        return 'Under Review';
      case ApplicationStatus.shortlisted:
        return 'Shortlisted';
      case ApplicationStatus.rejected:
        return 'Rejected';
      case ApplicationStatus.selected:
        return 'Selected';
    }
  }

  Color get statusColor {
    switch (status) {
      case ApplicationStatus.applied:
        return const Color(0xFF2196F3);
      case ApplicationStatus.underReview:
        return const Color(0xFFFFA726);
      case ApplicationStatus.shortlisted:
        return const Color(0xFF66BB6A);
      case ApplicationStatus.rejected:
        return const Color(0xFFEF5350);
      case ApplicationStatus.selected:
        return const Color(0xFF4CAF50);
    }
  }
}
