import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'payment_schedule_screen.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  bool _agreed = false;

  Widget _term(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMuted)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agreement')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: AppColors.gold, size: 22),
                    const SizedBox(height: 6),
                    const Text('GUURI',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text('Financing Agreement',
                        style: TextStyle(color: AppColors.textMuted)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Agreement #: GU-0001',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 14),
                    const Text('Between:',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    const Text('1. Family (Applicant)'),
                    const Text('2. Financing Partner'),
                    const Text('3. GUURI (Service Provider)'),
                    const SizedBox(height: 16),
                    const Text('Key Terms',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    _term('Final Sale Price:', '\$5,750'),
                    _term('Term:', '12 Months'),
                    _term('Monthly Payment:', '\$479.17'),
                    _term('Service Fee (GUURI):', '2% (\$100)'),
                    _term('Payment Method:', 'Bank Transfer / Mobile'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                title: const Text('I have read and agree to the terms and conditions.'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: () {}, child: const Text('View Agreement')),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _agreed
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const PaymentScheduleScreen()));
                      }
                    : null,
                child: const Text('Sign & Agree'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
