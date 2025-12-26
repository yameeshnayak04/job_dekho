class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String description;
  final List<String> requirements;
  final List<String> responsibilities;
  final double minCgpa;
  final List<String> eligibleBranches;
  final String package;
  final String deadline;
  final String postedDate;
  final String companyLogo;
  final List<String> skills;
  final String experienceLevel;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.description,
    required this.requirements,
    required this.responsibilities,
    required this.minCgpa,
    required this.eligibleBranches,
    required this.package,
    required this.deadline,
    required this.postedDate,
    required this.companyLogo,
    required this.skills,
    required this.experienceLevel,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      location: json['location'],
      type: json['type'],
      description: json['description'],
      requirements: List<String>.from(json['requirements']),
      responsibilities: List<String>.from(json['responsibilities']),
      minCgpa: json['minCgpa'].toDouble(),
      eligibleBranches: List<String>.from(json['eligibleBranches']),
      package: json['package'],
      deadline: json['deadline'],
      postedDate: json['postedDate'],
      companyLogo: json['companyLogo'],
      skills: List<String>.from(json['skills']),
      experienceLevel: json['experienceLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'type': type,
      'description': description,
      'requirements': requirements,
      'responsibilities': responsibilities,
      'minCgpa': minCgpa,
      'eligibleBranches': eligibleBranches,
      'package': package,
      'deadline': deadline,
      'postedDate': postedDate,
      'companyLogo': companyLogo,
      'skills': skills,
      'experienceLevel': experienceLevel,
    };
  }
}
