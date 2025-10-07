import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // จะถูกสร้างโดย flutterfire configure
import 'screens/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AS11App());
}

class AS11App extends StatelessWidget {
  const AS11App({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF7C3AED));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AS-11 Event Registration',
      theme: ThemeData(useMaterial3: true, colorScheme: scheme),
      home: const AuthGate(),
    );
  }
}
