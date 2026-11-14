import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _green = Color(0xFF0B3D2B);
const _greenBtn = Color(0xFF105C44);
const _gold = Color(0xFFC9A24B);
const _bg = Color(0xFFF6F6F4);

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  double _goal = 0;
  double _saved = 0;
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _goal = p.getDouble('goal') ?? 0;
      _saved = p.getDouble('saved') ?? 0;
      _history = p.getStringList('history') ?? [];
    });
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setDouble('goal', _goal);
    await p.setDouble('saved', _saved);
    await p.setStringList('history', _history);
  }

  Future<double?> _askAmount(String title) async {
    final c = TextEditingController();
    return showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: c,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(prefixText: '\$ '),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Jooji'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(ctx, double.tryParse(c.text.trim())),
            child: const Text('Kaydi'),
          ),
        ],
      ),
    );
  }

  Future<void> _setGoal() async {
    final v = await _askAmount('Hadafka kaydinta');
    if (v == null || v <= 0) return;
    setState(() => _goal = v);
    await _save();
  }

  Future<void> _addDeposit() async {
    final v = await _askAmount('Lacagta aad kaydisay');
    if (v == null || v <= 0) return;
    final d = DateTime.now();
    setState(() {
      _saved += v;
      _history.insert(
          0, '${d.day}/${d.month}/${d.year}|${v.toStringAsFixed(2)}');
    });
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        _goal > 0 ? (_saved / _goal).clamp(0.0, 1.0).toDouble() : 0.0;
    final left = (_goal - _saved).clamp(0, double.infinity);

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        title: const Text('Kaydinta Guurka'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Waxaad kaydisay',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text('\$${_saved.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(_gold),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _goal > 0
                      ? '${(progress * 100).toStringAsFixed(0)}% ka mid ah \$${_goal.toStringAsFixed(0)}  •  Harsan: \$${left.toStringAsFixed(2)}'
                      : 'Weli hadaf ma dejin',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _setGoal,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _greenBtn,
                    side: const BorderSide(color: _greenBtn),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Deji hadaf'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _goal > 0 ? _addDeposit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _greenBtn,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Ku dar kaydin'),
                ),
              ),
            ],
          ),
          if (_goal > 0 && progress >= 0.3) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _gold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Hambalyo! Waxaad gaartay 30%. Hadda waad codsan kartaa maalgelin dheeri ah.',
                style: TextStyle(color: _green, fontSize: 14),
              ),
            ),
          ],
          const SizedBox(height: 24),
          const Text('Taariikhda kaydinta',
              style: TextStyle(
                  color: _green, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (_history.isEmpty)
            const Text('Weli wax kaydin ah ma jiraan.',
                style: TextStyle(color: Colors.black54)),
          ..._history.map((h) {
            final parts = h.split('|');
            return Card(
              color: Colors.white,
              elevation: 0,
              child: ListTile(
                leading: const Icon(Icons.savings_outlined, color: _greenBtn),
                title: Text('\$${parts[1]}'),
                subtitle: Text(parts[0]),
              ),
            );
          }),
        ],
      ),
    );
  }
}
