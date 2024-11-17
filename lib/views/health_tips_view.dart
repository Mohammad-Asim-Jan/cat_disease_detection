import 'package:flutter/material.dart';

class HealthTipsView extends StatefulWidget {
  const HealthTipsView({super.key});

  @override
  State<HealthTipsView> createState() => _HealthTipsViewState();
}

class _HealthTipsViewState extends State<HealthTipsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Tips'),),
    );
  }
}
