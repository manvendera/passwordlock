import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/attempt_provider.dart';
import 'screens/pin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final attemptProvider = AttemptProvider();
  await attemptProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: attemptProvider),
      ],
      child: const PinLoggerApp(),
    ),
  );
}

class PinLoggerApp extends StatelessWidget {
  const PinLoggerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PinLoggerX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const PinScreen(),
    );
  }
}
