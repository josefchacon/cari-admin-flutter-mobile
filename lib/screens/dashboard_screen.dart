import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/survey_data.dart';
import '../services/firebase_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> selectedPlatforms = [];
  final List<String> platforms = [
    'Amazon',
    'Rappi',
    'Western Union',
    'Redes sociales',
    'Remitly',
    'Mi tía la que está en todo 😄',
    'Ria'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Cari'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<SurveyData>>(
        stream: FirebaseService.getSurveys(),
        builder: (context, surveySnapshot) {
          return StreamBuilder<List<NoReasonData>>(
            stream: FirebaseService.getNoReasons(),
            builder: (context, noReasonSnapshot) {
              if (surveySnapshot.connectionState == ConnectionState.waiting ||
                  noReasonSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final surveys = surveySnapshot.data ?? [];
              final noReasons = noReasonSnapshot.data ?? [];
              final totalResponses = surveys.length + noReasons.length;

              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildStatsCards(surveys, noReasons, totalResponses),
                    SizedBox(height: 20),
                    _buildSurveysSection(surveys),
                    SizedBox(height: 20),
                    _buildNoReasonsSection(noReasons),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatsCards(List<SurveyData> surveys, List<NoReasonData> noReasons, int total) {
    final completedPercentage = total > 0 ? ((surveys.length / total) * 100).round() : 0;
    final rejectedPercentage = total > 0 ? ((noReasons.length / total) * 100).round() : 0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Completadas',
            surveys.length.toString(),
            '$completedPercentage%',
            Colors.green,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            'No Interesados',
            noReasons.length.toString(),
            '$rejectedPercentage%',
            Colors.red,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            'Total',
            total.toString(),
            '100%',
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String percentage, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(percentage, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildSurveysSection(List<SurveyData> surveys) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Encuestas Completadas (${surveys.length})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: surveys.length,
              itemBuilder: (context, index) {
                final survey = surveys[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text('${survey.recipients.join(', ')}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Frecuencia: ${survey.frequency}'),
                        Text('Precio: ${survey.price}'),
                        Text('Email: ${survey.email ?? 'N/A'}'),
                      ],
                    ),
                    trailing: Text(
                      survey.timestamp != null
                          ? DateFormat('dd/MM/yyyy').format(survey.timestamp!.toDate())
                          : 'N/A',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoReasonsSection(List<NoReasonData> noReasons) {
    final filteredReasons = selectedPlatforms.isEmpty
        ? noReasons
        : noReasons.where((reason) =>
            reason.platforms?.any((p) => selectedPlatforms.contains(p)) ?? false).toList();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Razones de No Interés (${filteredReasons.length})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildPlatformFilters(noReasons),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredReasons.length,
              itemBuilder: (context, index) {
                final reason = filteredReasons[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(reason.reason),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (reason.platforms != null && reason.platforms!.isNotEmpty)
                          Text('Plataformas: ${reason.platforms!.join(', ')}',
                              style: TextStyle(color: Colors.blue[600])),
                        Text(
                          reason.timestamp != null
                              ? DateFormat('dd/MM/yyyy').format(reason.timestamp!.toDate())
                              : 'N/A',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformFilters(List<NoReasonData> noReasons) {
    final platformStats = <String, int>{};
    for (String platform in platforms) {
      platformStats[platform] = noReasons
          .where((reason) => reason.platforms?.contains(platform) ?? false)
          .length;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Filtrar por plataformas:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: platforms.map((platform) {
            final isSelected = selectedPlatforms.contains(platform);
            return FilterChip(
              label: Text('$platform (${platformStats[platform]})'),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedPlatforms.add(platform);
                  } else {
                    selectedPlatforms.remove(platform);
                  }
                });
              },
            );
          }).toList(),
        ),
        if (selectedPlatforms.isNotEmpty)
          TextButton(
            onPressed: () => setState(() => selectedPlatforms.clear()),
            child: Text('Limpiar filtros'),
          ),
      ],
    );
  }
}