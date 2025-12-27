import 'package:flutter/material.dart';

import '../models/job.dart';
import '../services/job_service.dart';
import 'job_detail_screen.dart';

class JobSwipeScreen extends StatefulWidget {
  const JobSwipeScreen({super.key});

  @override
  State<JobSwipeScreen> createState() => _JobSwipeScreenState();
}

class _JobSwipeScreenState extends State<JobSwipeScreen> {
  final JobService _jobService = JobService();

  late final List<Job> _jobs;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _jobs = List<Job>.from(_jobService.getMockJobs());
  }

  Job? get _currentJob {
    if (_currentIndex < 0 || _currentIndex >= _jobs.length) return null;
    return _jobs[_currentIndex];
  }

  void _advance() {
    setState(() {
      _currentIndex += 1;
    });
  }

  Future<void> _openDetails(Job job) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JobDetailScreen(job: job)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final job = _currentJob;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover Jobs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: job == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done_all,
                      size: 64,
                      color: theme.colorScheme.primary.withOpacity(0.6),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You’re all caught up',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No more jobs to swipe right now.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Dismissible(
                        key: ValueKey(job.id),
                        direction: DismissDirection.horizontal,
                        // startToEnd (LTR): swipe right -> Interested
                        background: _SwipeBackground(
                          alignment: Alignment.centerLeft,
                          icon: Icons.favorite,
                          label: 'Interested',
                          color: theme.colorScheme.primaryContainer,
                          foreground: theme.colorScheme.onPrimaryContainer,
                        ),
                        // endToStart (LTR): swipe left -> Skip
                        secondaryBackground: _SwipeBackground(
                          alignment: Alignment.centerRight,
                          icon: Icons.close,
                          label: 'Skip',
                          color: theme.colorScheme.errorContainer,
                          foreground: theme.colorScheme.onErrorContainer,
                        ),
                        onDismissed: (direction) async {
                          final dismissedJob = job;
                          _advance();

                          if (!mounted) return;

                          if (direction == DismissDirection.startToEnd) {
                            await _openDetails(dismissedJob);
                          }
                        },
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.62,
                          child: _JobSwipeCard(
                            job: job,
                            onTap: () => _openDetails(job),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.swipe_left, color: theme.hintColor),
                          const SizedBox(width: 8),
                          Text('Swipe left to skip',
                              style: theme.textTheme.bodySmall),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Swipe right for details',
                              style: theme.textTheme.bodySmall),
                          const SizedBox(width: 8),
                          Icon(Icons.swipe_right, color: theme.hintColor),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class _JobSwipeCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const _JobSwipeCard({required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        job.companyLogo,
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.title,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              job.company,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.work_outline, size: 18),
                        label: Text(job.type),
                      ),
                      Chip(
                        avatar: const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                        ),
                        label: Text(job.location),
                      ),
                      Chip(
                        avatar: const Icon(Icons.currency_rupee, size: 18),
                        label: Text(job.package),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    job.description,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: job.skills.take(4).map((s) {
                      return Chip(
                        label: Text(s),
                        backgroundColor: theme.colorScheme.secondaryContainer,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tap for job details & apply',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  final Alignment alignment;
  final IconData icon;
  final String label;
  final Color color;
  final Color foreground;

  const _SwipeBackground({
    required this.alignment,
    required this.icon,
    required this.label,
    required this.color,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: color),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: foreground),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
