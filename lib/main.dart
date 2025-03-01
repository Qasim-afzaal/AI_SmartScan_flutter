import 'package:barcode_scanner/presentation/screens/scan_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ScanViewModel()),
      ],
      child: MaterialApp(
        title: 'Smart Scanner',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/': (context) => const AuthWrapper(),
          '/home': (context) => const HomeScreen(),
          '/scan': (context) => FutureBuilder(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ScanScreen(cameras: snapshot.data!);
              }
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          ),
          '/result': (context) => const ResultScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepository();
    return StreamBuilder<User?>(
      stream: authRepo.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return snapshot.hasData ? const HomeScreen() : const AuthScreen();
      },
    );
  }
}