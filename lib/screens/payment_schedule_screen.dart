import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PaymentScheduleScreen extends StatelessWidget {
  const PaymentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = List.generate(5, (i) {
      final months = ['May', 'Jun', 'Jul', 'Aug', 'Sep'];
      return {
        'no': '${i + 1}',
        'date': '10 ${months[i]} 2025',
        'amount': '\$479.17',
        'status': 'Pending',
      };
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Payment Schedule')),
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
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Amount',
                            style: TextStyle(color: Colors.white70, fontSize: 12)),
                        SizedBox(height: 4),
                        Text('\$5,750',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Monthly Payment',
                            style: TextStyle(color: Colors.white70, fontSize: 12)),
                        SizedBox(height: 4),
                        Text('\$479.17',
                            style: TextStyle(
                                color: AppColors.goldLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text('Term: 12 Months',
                  style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: payments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final p = payments[i];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.primary.withOpacity(0.08),
                            child: Text(p['no']!,
                                style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(p['date']!,
                                style: const TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          Text(p['amount']!,
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(p['status']!,
                                style: const TextStyle(
                                    color: AppColors.warning,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('View All Payments')),
            ],
          ),
        ),
      ),
    );
  }
}
