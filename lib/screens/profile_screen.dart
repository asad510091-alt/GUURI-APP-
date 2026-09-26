import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _tile(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.cardBorder,
                child: Icon(Icons.person, size: 42, color: AppColors.textMuted),
              ),
              const SizedBox(height: 12),
              const Text('Ayaan Ahmed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              const Text('+252 61 2345678', style: TextStyle(color: AppColors.textMuted)),
              const Text('ayaan@example.com', style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 24),
              _tile(Icons.person_outline, 'Personal Information'),
              _tile(Icons.people_outline, 'Family Information'),
              _tile(Icons.description_outlined, 'Documents'),
              _tile(Icons.payment_outlined, 'Payment Methods'),
              _tile(Icons.settings_outlined, 'Settings'),
              _tile(Icons.help_outline, 'Help & Support'),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.danger,
                    side: const BorderSide(color: AppColors.danger),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
