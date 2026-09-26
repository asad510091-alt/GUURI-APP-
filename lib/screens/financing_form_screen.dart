import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'documents_screen.dart';

class FinancingFormScreen extends StatefulWidget {
  const FinancingFormScreen({super.key});

  @override
  State<FinancingFormScreen> createState() => _FinancingFormScreenState();
}

class _FinancingFormScreenState extends State<FinancingFormScreen> {
  final _amountController = TextEditingController(text: '5,000');
  final _incomeController = TextEditingController(text: '1,000');
  String _purpose = 'Wedding Expenses';
  String _term = '12 Months';
  String _occupation = 'Business Owner';

  Widget _stepDot(int index, {required bool active, required bool done}) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: done || active ? AppColors.primary : AppColors.cardBorder,
      child: done
          ? const Icon(Icons.check, color: Colors.white, size: 16)
          : Text('$index',
              style: TextStyle(
                  color: active ? Colors.white : AppColors.textMuted,
                  fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const steps = ['Details', 'Docs', 'Review', 'Submit'];
    return Scaffold(
      appBar: AppBar(title: const Text('Marriage Financing')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(steps.length, (i) {
                  return Expanded(
                    child: Row(
                      children: [
                        _stepDot(i + 1, active: i == 0, done: false),
                        if (i != steps.length - 1)
                          Expanded(
                            child: Container(
                              height: 2,
                              color: AppColors.cardBorder,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              const Text('1. Personal & Financial Information',
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              const Text('Requested Amount (USD)',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(prefixText: '\$ '),
              ),
              const SizedBox(height: 16),
              const Text('Purpose of Funds',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              _Dropdown(
                value: _purpose,
                items: const [
                  'Wedding Expenses',
                  'Dowry / Mahr',
                  'Home Setup',
                  'Furniture'
                ],
                onChanged: (v) => setState(() => _purpose = v),
              ),
              const SizedBox(height: 16),
              const Text('Preferred Term',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              _Dropdown(
                value: _term,
                items: const ['6 Months', '12 Months', '18 Months', '24 Months'],
                onChanged: (v) => setState(() => _term = v),
              ),
              const SizedBox(height: 16),
              const Text('Monthly Income (USD)',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              TextField(
                controller: _incomeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(prefixText: '\$ '),
              ),
              const SizedBox(height: 16),
              const Text('Occupation',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              _Dropdown(
                value: _occupation,
                items: const [
                  'Business Owner',
                  'Employee',
                  'Self-Employed',
                  'Student'
                ],
                onChanged: (v) => setState(() => _occupation = v),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const DocumentsScreen()));
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _Dropdown(
      {required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}
