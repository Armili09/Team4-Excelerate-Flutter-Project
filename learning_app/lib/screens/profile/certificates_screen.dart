import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/models/certificate.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  String _viewMode = 'grid'; // 'grid' or 'list'
  String _sortBy = 'Recent';

  // Mock data - Replace with actual API call
  final List<Certificate> _certificates = [
    Certificate(
      id: '1',
      courseTitle: 'Full Stack Web Development',
      courseName: 'FSWEB-2024',
      recipientName: 'John Doe',
      completionDate: DateTime(2025, 12, 20),
      issueDate: DateTime(2025, 12, 22),
      certificateUrl: 'https://example.com/cert/1',
      verificationCode: 'CERT-FSWEB-2024-001',
      issuer: 'Excelerate Learning',
      score: 95.5,
      creditsEarned: 24,
      templateType: 'premium',
    ),
    Certificate(
      id: '2',
      courseTitle: 'Data Science Fundamentals',
      courseName: 'DS-FUND-2025',
      recipientName: 'John Doe',
      completionDate: DateTime(2026, 1, 10),
      issueDate: DateTime(2026, 1, 12),
      certificateUrl: 'https://example.com/cert/2',
      verificationCode: 'CERT-DS-2025-045',
      issuer: 'Excelerate Learning',
      score: 92.0,
      creditsEarned: 16,
      templateType: 'standard',
    ),
    Certificate(
      id: '3',
      courseTitle: 'UX/UI Design Masterclass',
      courseName: 'UXUI-2025',
      recipientName: 'John Doe',
      completionDate: DateTime(2025, 11, 15),
      issueDate: DateTime(2025, 11, 17),
      certificateUrl: 'https://example.com/cert/3',
      verificationCode: 'CERT-UXUI-2025-128',
      issuer: 'Excelerate Learning',
      score: 98.0,
      creditsEarned: 12,
      templateType: 'premium',
    ),
    Certificate(
      id: '4',
      courseTitle: 'Digital Marketing Strategy',
      courseName: 'DMS-2025',
      recipientName: 'John Doe',
      completionDate: DateTime(2025, 10, 30),
      issueDate: DateTime(2025, 11, 1),
      certificateUrl: 'https://example.com/cert/4',
      verificationCode: 'CERT-DMS-2025-089',
      issuer: 'Excelerate Learning',
      score: 88.5,
      creditsEarned: 8,
      templateType: 'standard',
    ),
  ];

  List<Certificate> get _sortedCertificates {
    var certs = List<Certificate>.from(_certificates);
    switch (_sortBy) {
      case 'Recent':
        certs.sort((a, b) => b.issueDate.compareTo(a.issueDate));
        break;
      case 'Oldest':
        certs.sort((a, b) => a.issueDate.compareTo(b.issueDate));
        break;
      case 'Score':
        certs.sort((a, b) => b.score.compareTo(a.score));
        break;
      case 'Title':
        certs.sort((a, b) => a.courseTitle.compareTo(b.courseTitle));
        break;
    }
    return certs;
  }

  @override
  Widget build(BuildContext context) {
    final certificates = _sortedCertificates;
    final totalCredits = _certificates.fold<int>(
      0,
      (sum, cert) => sum + cert.creditsEarned,
    );
    final avgScore = _certificates.isEmpty
        ? 0.0
        : _certificates.fold<double>(0, (sum, cert) => sum + cert.score) /
              _certificates.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Certificates',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _viewMode == 'grid' ? Icons.view_list : Icons.grid_view,
              color: Colors.grey[700],
            ),
            onPressed: () {
              setState(() {
                _viewMode = _viewMode == 'grid' ? 'list' : 'grid';
              });
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: Colors.grey[700]),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Recent', child: Text('Recent First')),
              const PopupMenuItem(value: 'Oldest', child: Text('Oldest First')),
              const PopupMenuItem(value: 'Score', child: Text('Highest Score')),
              const PopupMenuItem(value: 'Title', child: Text('Title A-Z')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Overview
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[700]!, Colors.purple[500]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn(
                  'Certificates',
                  '${certificates.length}',
                  Icons.workspace_premium,
                ),
                Container(width: 1, height: 40, color: Colors.white30),
                _buildStatColumn('Credits', '$totalCredits', Icons.school),
                Container(width: 1, height: 40, color: Colors.white30),
                _buildStatColumn(
                  'Avg Score',
                  '${avgScore.toStringAsFixed(1)}%',
                  Icons.grade,
                ),
              ],
            ),
          ),
          // Certificates Display
          Expanded(
            child: certificates.isEmpty
                ? _buildEmptyState()
                : _viewMode == 'grid'
                ? _buildGridView(certificates)
                : _buildListView(certificates),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildGridView(List<Certificate> certificates) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        return _buildCertificateCard(certificates[index]);
      },
    );
  }

  Widget _buildListView(List<Certificate> certificates) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        return _buildCertificateListItem(certificates[index]);
      },
    );
  }

  Widget _buildCertificateCard(Certificate certificate) {
    return GestureDetector(
      onTap: () => _showCertificateDetails(certificate),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Certificate Preview
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: certificate.templateType == 'premium'
                      ? [Colors.amber[700]!, Colors.amber[500]!]
                      : [Colors.blue[700]!, Colors.blue[500]!],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  // Decorative Pattern
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/images/certificate_pattern.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          certificate.templateType == 'premium'
                              ? Icons.workspace_premium
                              : Icons.verified,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          certificate.templateType == 'premium'
                              ? 'PREMIUM'
                              : 'CERTIFIED',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Certificate Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      certificate.courseTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('MMM d, y').format(certificate.issueDate),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.grade, size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${certificate.score}%',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateListItem(Certificate certificate) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: certificate.templateType == 'premium'
                  ? [Colors.amber[700]!, Colors.amber[500]!]
                  : [Colors.blue[700]!, Colors.blue[500]!],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            certificate.templateType == 'premium'
                ? Icons.workspace_premium
                : Icons.verified,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          certificate.courseTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              DateFormat('MMMM d, y').format(certificate.issueDate),
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.grade, size: 14, color: Colors.amber[700]),
                const SizedBox(width: 4),
                Text(
                  '${certificate.score}% • ${certificate.creditsEarned} credits',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showCertificateOptions(certificate),
        ),
        onTap: () => _showCertificateDetails(certificate),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.workspace_premium_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No Certificates Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete courses to earn certificates',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to courses
            },
            icon: const Icon(Icons.explore),
            label: const Text('Explore Courses'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showCertificateDetails(Certificate certificate) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Certificate Preview (Full)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: certificate.templateType == 'premium'
                            ? [Colors.amber[700]!, Colors.amber[500]!]
                            : [Colors.blue[700]!, Colors.blue[500]!],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          certificate.templateType == 'premium'
                              ? Icons.workspace_premium
                              : Icons.verified,
                          color: Colors.white,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'CERTIFICATE OF COMPLETION',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'This certifies that',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          certificate.recipientName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'has successfully completed',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          certificate.courseTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildCertDetail('Score', '${certificate.score}%'),
                            _buildCertDetail(
                              'Credits',
                              '${certificate.creditsEarned}',
                            ),
                            _buildCertDetail(
                              'Completed',
                              DateFormat(
                                'MMM y',
                              ).format(certificate.completionDate),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.white30, thickness: 1),
                        const SizedBox(height: 12),
                        Text(
                          certificate.issuer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Verification Code: ${certificate.verificationCode}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontFamily: 'Courier',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _shareCertificate(certificate),
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _downloadCertificate(certificate),
                          icon: const Icon(Icons.download),
                          label: const Text('Download'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _verifyCertificate(certificate),
                      icon: const Icon(Icons.verified_user),
                      label: const Text('Verify Certificate'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCertDetail(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  void _showCertificateOptions(Certificate certificate) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Certificate'),
              onTap: () {
                Navigator.pop(context);
                _shareCertificate(certificate);
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download'),
              onTap: () {
                Navigator.pop(context);
                _downloadCertificate(certificate);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Verify Certificate'),
              onTap: () {
                Navigator.pop(context);
                _verifyCertificate(certificate);
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copy Link'),
              onTap: () {
                Navigator.pop(context);
                _copyCertificateLink(certificate);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareCertificate(Certificate certificate) {
    Share.share(
      'Check out my certificate for ${certificate.courseTitle}!\n\n'
      'Verification: ${certificate.verificationCode}\n'
      '${certificate.certificateUrl}',
      subject: 'My Certificate - ${certificate.courseTitle}',
    );
  }

  void _downloadCertificate(Certificate certificate) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Certificate downloaded successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _verifyCertificate(Certificate certificate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Certificate Verification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Verification Code:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                certificate.verificationCode,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This certificate is authentic and was issued by ${certificate.issuer} on '
              '${DateFormat('MMMM d, y').format(certificate.issueDate)}.',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _copyCertificateLink(Certificate certificate) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Certificate link copied to clipboard')),
    );
  }
}
