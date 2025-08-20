import 'package:flutter/material.dart';
import 'package:synapse/core/theme/theme.dart';
import 'package:synapse/presentation/screens/home/home_screen.dart';

void main() {
  runApp(const SynapseApp());
}

class SynapseApp extends StatelessWidget {
  const SynapseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const HomeScreen()
    );
  }
}

