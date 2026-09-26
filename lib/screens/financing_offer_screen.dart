import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'agreement_screen.dart';

class FinancingOfferScreen extends StatelessWidget {
  const FinancingOfferScreen({super.key});

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMuted)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financing Offer')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      backgroundColor: AppColors.success,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('Congratulations!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      'Your application has been approved by our financing partner.',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  children: [
                    _row('Requested Amount', '\$5,000'),
                    _row('Financing Structure', 'Murabaha (Halal)'),
                    _row('Final Agreed Price', '\$5,750', bold: true),
                    _row('Term', '12 Months'),
                    _row('Monthly Payment', '\$479.17', bold: true),
                    const Divider(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Key Benefits',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 8),
                    _benefit('Sharia-compliant'),
                    _benefit('No interest (Riba)'),
                    _benefit('Transparent & fair'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {},
                child: const Text('View Agreement'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AgreementScreen()));
                },
                child: const Text('Accept Offer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _benefit(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          const Icon(Icons.check, color: AppColors.success, size: 18),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
