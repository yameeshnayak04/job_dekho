import '../models/job.dart';

class JobService {
  static final JobService _instance = JobService._internal();
  factory JobService() => _instance;
  JobService._internal();

  List<Job> getMockJobs() {
    return [
      Job(
        id: '1',
        title: 'Software Development Engineer',
        company: 'Tech Innovators Inc.',
        location: 'Bangalore, Karnataka',
        type: 'Full-time',
        description:
            'We are looking for a passionate software engineer to join our growing team. You will work on cutting-edge technologies and contribute to building scalable applications that impact millions of users.',
        requirements: [
          'Bachelor\'s degree in Computer Science or related field',
          'Strong knowledge of data structures and algorithms',
          'Proficiency in at least one programming language (Java, Python, C++)',
          'Understanding of OOP concepts',
          'Good problem-solving skills',
        ],
        responsibilities: [
          'Design, develop, and maintain software applications',
          'Collaborate with cross-functional teams',
          'Participate in code reviews and technical discussions',
          'Debug and resolve technical issues',
          'Write clean, maintainable, and efficient code',
        ],
        minCgpa: 7.0,
        eligibleBranches: ['CSE', 'IT', 'ECE'],
        package: '₹12-15 LPA',
        deadline: '2026-01-15',
        postedDate: '2025-12-20',
        companyLogo: '🏢',
        skills: ['Java', 'Python', 'DSA', 'System Design'],
        experienceLevel: 'Entry Level',
      ),
      Job(
        id: '2',
        title: 'Frontend Developer Intern',
        company: 'Creative Solutions Ltd.',
        location: 'Remote',
        type: 'Internship',
        description:
            'Join our frontend team and work on exciting web applications. This internship offers hands-on experience with modern frameworks and a chance to learn from experienced developers.',
        requirements: [
          'Pursuing Bachelor\'s degree in Computer Science',
          'Knowledge of HTML, CSS, JavaScript',
          'Familiarity with React or Flutter',
          'Passion for creating beautiful user interfaces',
          'Good communication skills',
        ],
        responsibilities: [
          'Develop responsive web interfaces',
          'Implement designs from Figma/XD',
          'Work with backend APIs',
          'Optimize application performance',
          'Learn and adapt to new technologies',
        ],
        minCgpa: 6.5,
        eligibleBranches: ['CSE', 'IT', 'ECE', 'EEE'],
        package: '₹15,000/month',
        deadline: '2026-01-10',
        postedDate: '2025-12-22',
        companyLogo: '🎨',
        skills: ['React', 'JavaScript', 'CSS', 'HTML'],
        experienceLevel: 'Internship',
      ),
      Job(
        id: '3',
        title: 'Data Analyst',
        company: 'Analytics Pro',
        location: 'Mumbai, Maharashtra',
        type: 'Full-time',
        description:
            'We are seeking a data analyst who can transform raw data into actionable insights. You will work with large datasets and help drive business decisions through data-driven strategies.',
        requirements: [
          'Bachelor\'s degree in relevant field',
          'Strong analytical and problem-solving skills',
          'Proficiency in SQL and Excel',
          'Knowledge of Python or R for data analysis',
          'Understanding of statistical methods',
        ],
        responsibilities: [
          'Analyze complex datasets to identify trends',
          'Create dashboards and reports',
          'Collaborate with stakeholders to understand requirements',
          'Perform data cleaning and preprocessing',
          'Present findings to management',
        ],
        minCgpa: 7.5,
        eligibleBranches: ['CSE', 'IT', 'Mathematics', 'Statistics'],
        package: '₹8-10 LPA',
        deadline: '2026-01-20',
        postedDate: '2025-12-18',
        companyLogo: '📊',
        skills: ['SQL', 'Python', 'Excel', 'Statistics'],
        experienceLevel: 'Entry Level',
      ),
      Job(
        id: '4',
        title: 'Backend Developer',
        company: 'CloudTech Systems',
        location: 'Hyderabad, Telangana',
        type: 'Full-time',
        description:
            'Looking for a backend developer to build robust and scalable server-side applications. You will work with microservices architecture and cloud technologies.',
        requirements: [
          'Bachelor\'s degree in Computer Science',
          'Strong knowledge of Node.js or Java',
          'Experience with databases (SQL/NoSQL)',
          'Understanding of RESTful APIs',
          'Familiarity with cloud platforms (AWS/Azure)',
        ],
        responsibilities: [
          'Design and implement backend services',
          'Optimize database queries and performance',
          'Implement security best practices',
          'Write unit and integration tests',
          'Deploy and monitor applications',
        ],
        minCgpa: 7.0,
        eligibleBranches: ['CSE', 'IT'],
        package: '₹10-14 LPA',
        deadline: '2026-01-25',
        postedDate: '2025-12-15',
        companyLogo: '⚙️',
        skills: ['Node.js', 'MongoDB', 'REST API', 'AWS'],
        experienceLevel: 'Entry Level',
      ),
      Job(
        id: '5',
        title: 'Machine Learning Intern',
        company: 'AI Innovations',
        location: 'Pune, Maharashtra',
        type: 'Internship',
        description:
            'Exciting opportunity to work on real-world ML projects. You will assist in developing machine learning models and gain exposure to cutting-edge AI technologies.',
        requirements: [
          'Pursuing degree in Computer Science or related field',
          'Strong foundation in mathematics and statistics',
          'Knowledge of Python and ML libraries',
          'Understanding of ML algorithms',
          'Enthusiasm to learn and experiment',
        ],
        responsibilities: [
          'Assist in data collection and preprocessing',
          'Implement ML models under guidance',
          'Conduct experiments and analyze results',
          'Document findings and learnings',
          'Stay updated with latest ML research',
        ],
        minCgpa: 8.0,
        eligibleBranches: ['CSE', 'IT', 'ECE'],
        package: '₹20,000/month',
        deadline: '2026-01-12',
        postedDate: '2025-12-23',
        companyLogo: '🤖',
        skills: ['Python', 'TensorFlow', 'Machine Learning', 'NumPy'],
        experienceLevel: 'Internship',
      ),
      Job(
        id: '6',
        title: 'Mobile App Developer',
        company: 'AppWorks Studio',
        location: 'Chennai, Tamil Nadu',
        type: 'Full-time',
        description:
            'Join our mobile team to create innovative apps for millions of users. You will work on both Android and iOS platforms using modern frameworks.',
        requirements: [
          'Bachelor\'s degree in Computer Science',
          'Experience with Flutter or React Native',
          'Understanding of mobile UI/UX principles',
          'Knowledge of state management',
          'Ability to work in an agile environment',
        ],
        responsibilities: [
          'Develop cross-platform mobile applications',
          'Integrate with backend APIs',
          'Optimize app performance',
          'Fix bugs and improve user experience',
          'Publish apps to stores',
        ],
        minCgpa: 6.8,
        eligibleBranches: ['CSE', 'IT', 'ECE'],
        package: '₹9-12 LPA',
        deadline: '2026-01-18',
        postedDate: '2025-12-21',
        companyLogo: '📱',
        skills: ['Flutter', 'Dart', 'Mobile Development', 'REST API'],
        experienceLevel: 'Entry Level',
      ),
    ];
  }

  Job? getJobById(String id) {
    try {
      return getMockJobs().firstWhere((job) => job.id == id);
    } catch (e) {
      return null;
    }
  }
}
