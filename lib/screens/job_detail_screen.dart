import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/application_service.dart';
import '../utils/constants.dart';
import 'apply_success_screen.dart';

class JobDetailScreen extends StatefulWidget {
  final Job job;

  const JobDetailScreen({super.key, required this.job});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  final ApplicationService _applicationService = ApplicationService();
  bool _hasApplied = false;

  @override
  void initState() {
    super.initState();
    _checkApplicationStatus();
  }

  void _checkApplicationStatus() {
    setState(() {
      _hasApplied = _applicationService.hasApplied(widget.job.id);
    });
  }

  void _applyToJob() {
    if (_hasApplied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have already applied to this job'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final application = _applicationService.applyToJob(widget.job);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ApplySuccessScreen(application: application),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
              ),
              child: Column(
                children: [
                  Text(
                    widget.job.companyLogo,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.job.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(widget.job.company, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.location_on, size: 18),
                        label: Text(widget.job.location),
                      ),
                      Chip(
                        avatar: const Icon(Icons.work, size: 18),
                        label: Text(widget.job.type),
                      ),
                      Chip(
                        avatar: const Icon(Icons.currency_rupee, size: 18),
                        label: Text(widget.job.package),
                      ),
                      Chip(
                        avatar: const Icon(Icons.grade, size: 18),
                        label: Text('Min CGPA ${widget.job.minCgpa}'),
                      ),
                      Chip(
                        avatar: const Icon(Icons.school, size: 18),
                        label: Text(
                          widget.job.eligibleBranches.take(2).join(', ') +
                              (widget.job.eligibleBranches.length > 2
                                  ? ' +${widget.job.eligibleBranches.length - 2}'
                                  : ''),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'About the Role',
                    widget.job.description,
                    theme,
                  ),
                  const SizedBox(height: 24),
                  _buildListSection(
                    'Key Responsibilities',
                    widget.job.responsibilities,
                    theme,
                  ),
                  const SizedBox(height: 24),
                  _buildListSection(
                    'Requirements',
                    widget.job.requirements,
                    theme,
                  ),
                  const SizedBox(height: 24),
                  _buildSkillsSection(theme),
                  const SizedBox(height: 24),
                  _buildEligibilitySection(theme),
                  const SizedBox(height: 24),
                  _buildTimelineSection(theme),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: FilledButton(
            onPressed: _hasApplied ? null : _applyToJob,
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              _hasApplied ? 'Already Applied' : 'Apply Now',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(content, style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(Icons.check_circle, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Skills',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.job.skills
              .map(
                (skill) => Chip(
                  label: Text(skill),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildEligibilitySection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eligibility Criteria',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildEligibilityRow(
              'Minimum CGPA',
              widget.job.minCgpa.toString(),
              Icons.grade,
              theme,
            ),
            const Divider(height: 24),
            _buildEligibilityRow(
              'Eligible Branches',
              widget.job.eligibleBranches
                  .map((b) => AppConstants.branchFullNames[b] ?? b)
                  .join(', '),
              Icons.school,
              theme,
            ),
            const Divider(height: 24),
            _buildEligibilityRow(
              'Experience Level',
              widget.job.experienceLevel,
              Icons.work_outline,
              theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEligibilityRow(
    String label,
    String value,
    IconData icon,
    ThemeData theme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineSection(ThemeData theme) {
    return Card(
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.access_time, color: theme.colorScheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Application Deadline',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.job.deadline,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
