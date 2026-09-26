import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'financing_offer_screen.dart';

class ApplicationStatusScreen extends StatelessWidget {
  const ApplicationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StepData('Application Submitted', '12 Apr 2025, 10:24 AM',
          _StepState.done),
      _StepData('Documents Verified', '12 Apr 2025, 02:15 PM',
          _StepState.done),
      _StepData('Financing Partner Review', 'In Progress',
          _StepState.active),
      _StepData('Approved', '', _StepState.pending),
      _StepData('Agreement', '', _StepState.pending),
      _StepData('Disbursement', '', _StepState.pending),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Application Status')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Application #GU-0001',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('Submitted on 12 Apr 2025',
                        style: TextStyle(color: AppColors.textMuted)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: steps.length,
                  itemBuilder: (context, i) {
                    final s = steps[i];
                    final isLast = i == steps.length - 1;
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              _dot(s.state),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: s.state == _StepState.done
                                        ? AppColors.success
                                        : AppColors.cardBorder,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 22),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(s.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: s.state == _StepState.pending
                                              ? AppColors.textMuted
                                              : AppColors.textDark)),
                                  if (s.subtitle.isNotEmpty)
                                    Text(s.subtitle,
                                        style: const TextStyle(
                                            color: AppColors.textMuted,
                                            fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const FinancingOfferScreen()));
                },
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(_StepState state) {
    if (state == _StepState.done) {
      return const CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.success,
        child: Icon(Icons.check, size: 14, color: Colors.white),
      );
    } else if (state == _StepState.active) {
      return const CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.warning,
        child: Icon(Icons.access_time, size: 14, color: Colors.white),
      );
    }
    return CircleAvatar(
      radius: 12,
      backgroundColor: AppColors.cardBorder,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
            color: Colors.white, shape: BoxShape.circle),
      ),
    );
  }
}

enum _StepState { done, active, pending }

class _StepData {
  final String title;
  final String subtitle;
  final _StepState state;
  _StepData(this.title, this.subtitle, this.state);
}
