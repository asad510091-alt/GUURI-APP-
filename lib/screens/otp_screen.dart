import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<String> _digits = List.filled(6, '');

  void _tapNumber(String n) {
    setState(() {
      final idx = _digits.indexOf('');
      if (idx != -1) _digits[idx] = n;
    });
  }

  void _backspace() {
    setState(() {
      for (int i = _digits.length - 1; i >= 0; i--) {
        if (_digits[i].isNotEmpty) {
          _digits[i] = '';
          break;
        }
      }
    });
  }

  Widget _numKey(String label, {IconData? icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () => _tapNumber(label),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 68,
        height: 68,
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, size: 24)
            : Text(label,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text('Verify Your Number',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("We've sent a 6-digit code to",
                style: TextStyle(color: AppColors.textMuted)),
            const Text('+252 61 2345678',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (i) {
                final filled = _digits[i].isNotEmpty;
                return Container(
                  width: 42,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: filled ? AppColors.primary : AppColors.cardBorder,
                      width: filled ? 1.5 : 1,
                    ),
                  ),
                  child: Text(_digits[i],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                );
              }),
            ),
            const SizedBox(height: 16),
            const Text('Resend Code (00:45)',
                style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Verify'),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                for (final row in [
                  ['1', '2', '3'],
                  ['4', '5', '6'],
                  ['7', '8', '9'],
                ])
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        row.map((n) => _numKey(n)).toList(growable: false),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 68),
                    _numKey('0'),
                    _numKey('', icon: Icons.backspace_outlined,
                        onTap: _backspace),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
