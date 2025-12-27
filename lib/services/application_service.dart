import '../models/application.dart';
import '../models/job.dart';
import '../models/ats_score.dart';
import 'dart:math';

class ApplicationService {
  static final ApplicationService _instance = ApplicationService._internal();
  factory ApplicationService() => _instance;
  ApplicationService._internal();

  final List<Application> _applications = [];
  final Random _random = Random();

  List<Application> getApplications() {
    return List.unmodifiable(_applications);
  }

  bool hasApplied(String jobId) {
    return _applications.any((app) => app.job.id == jobId);
  }

  Application applyToJob(Job job) {
    final atsScore = _generateMockATSScore(job);

    final application = Application(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      job: job,
      appliedDate: DateTime.now(),
      status: ApplicationStatus.applied,
      atsScore: atsScore,
      statusMessage: 'Your application has been submitted successfully',
    );

    _applications.add(application);
    return application;
  }

  ATSScore _generateMockATSScore(Job job) {
    final baseScore = 60 + _random.nextInt(35);

    final breakdown = {
      'Skills Match': 70 + _random.nextInt(25),
      'Experience': 55 + _random.nextInt(30),
      'Education': 75 + _random.nextInt(20),
      'Keywords': 65 + _random.nextInt(30),
    };

    final strengths = <String>[];
    final improvements = <String>[];

    if (breakdown['Skills Match']! >= 80) {
      strengths.add('Strong technical skills alignment');
    } else if (breakdown['Skills Match']! < 60) {
      improvements.add(
        'Consider gaining more skills from the job requirements',
      );
    }

    if (breakdown['Education']! >= 85) {
      strengths.add('Excellent academic background');
    }

    if (breakdown['Keywords']! >= 75) {
      strengths.add('Resume well-optimized with relevant keywords');
    } else if (breakdown['Keywords']! < 65) {
      improvements.add('Include more industry-specific keywords');
    }

    if (breakdown['Experience']! < 70) {
      improvements.add('Highlight relevant projects and internships');
    } else {
      strengths.add('Good experience profile');
    }

    final keywordPool = <String>{
      ...job.skills,
      'Git',
      'REST',
      'Problem Solving',
      'Teamwork',
    }.toList();
    keywordPool.shuffle(_random);

    final missingCount = _random.nextInt(4); // 0..3
    final missingKeywords = keywordPool.take(missingCount).toList();

    return ATSScore(
      overallScore: baseScore,
      breakdown: breakdown,
      strengths: strengths,
      improvements: improvements,
      missingKeywords: missingKeywords,
    );
  }
}
