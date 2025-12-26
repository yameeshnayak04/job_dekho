import 'dart:ui';

class ATSScore {
  final int overallScore;
  final Map<String, int> breakdown;
  final List<String> strengths;
  final List<String> improvements;

  ATSScore({
    required this.overallScore,
    required this.breakdown,
    required this.strengths,
    required this.improvements,
  });

  String get rating {
    if (overallScore >= 85) return 'Excellent';
    if (overallScore >= 70) return 'Good';
    if (overallScore >= 50) return 'Average';
    return 'Needs Improvement';
  }

  Color get color {
    if (overallScore >= 85) return const Color(0xFF4CAF50);
    if (overallScore >= 70) return const Color(0xFF66BB6A);
    if (overallScore >= 50) return const Color(0xFFFFA726);
    return const Color(0xFFEF5350);
  }
}
