import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'application_status_screen.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocItem {
  final IconData icon;
  final String title;
  final String subtitle;
  bool uploaded;
  _DocItem(this.icon, this.title, this.subtitle, {this.uploaded = false});
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final List<_DocItem> _docs = [
    _DocItem(Icons.badge_outlined, 'National ID', 'Upload front & back',
        uploaded: true),
    _DocItem(Icons.receipt_long_outlined, 'Proof of Income',
        'Salary slip / Business docs', uploaded: true),
    _DocItem(Icons.family_restroom_outlined, 'Family Approval Letter',
        'Signed letter from family'),
    _DocItem(Icons.event_note_outlined, 'Marriage Plan / Budget',
        'Details of wedding expenses'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please upload the required documents',
                  style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: _docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final doc = _docs[i];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                Icon(doc.icon, color: AppColors.primary),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doc.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Text(doc.subtitle,
                                    style: const TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                setState(() => doc.uploaded = !doc.uploaded),
                            child: Icon(
                              doc.uploaded
                                  ? Icons.check_circle
                                  : Icons.upload_outlined,
                              color: doc.uploaded
                                  ? AppColors.success
                                  : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ApplicationStatusScreen()));
                },
                child: const Text('Submit Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
