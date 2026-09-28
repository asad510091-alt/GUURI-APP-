import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bywhzjoairxegnfjelsn.supabase.co',
    anonKey: 'sb_publishable_gKLLjhx19Q-efOzbiEMCoQ_86VTPMsJ',
  );

  runApp(const GuuriApp());
}

class GuuriApp extends StatelessWidget {
  const GuuriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GUURI',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final session = snapshot.data?.session ??
              Supabase.instance.client.auth.currentSession;
          return session == null ? const LoginScreen() : const HomeScreen();
        },
      ),
    );
  }
}
