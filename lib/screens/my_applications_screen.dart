import 'package:flutter/material.dart';
import 'package:job_dekho/models/application.dart';
import '../services/application_service.dart';
import '../widgets/application_card.dart';

class MyApplicationsScreen extends StatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  final ApplicationService _applicationService = ApplicationService();

  @override
  Widget build(BuildContext context) {
    final applications = _applicationService.getApplications();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Applications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: applications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No applications yet',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start applying to jobs to see them here',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    color: theme.colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStat(
                            'Total',
                            applications.length.toString(),
                            theme,
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: theme.colorScheme.outline,
                          ),
                          _buildStat(
                            'Under Review',
                            applications
                                .where(
                                  (a) =>
                                      a.status == ApplicationStatus.underReview,
                                )
                                .length
                                .toString(),
                            theme,
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: theme.colorScheme.outline,
                          ),
                          _buildStat(
                            'Shortlisted',
                            applications
                                .where(
                                  (a) =>
                                      a.status == ApplicationStatus.shortlisted,
                                )
                                .length
                                .toString(),
                            theme,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: applications.length,
                    itemBuilder: (context, index) {
                      final application =
                          applications[applications.length - 1 - index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ApplicationCard(application: application),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStat(String label, String value, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}
