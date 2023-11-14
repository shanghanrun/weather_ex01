import 'package:flutter/material.dart';

class ScreenB extends StatefulWidget {
  const ScreenB({super.key});

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {
  @override
  void initState() {
    super.initState();
    print('initState is called');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose is called');
  }

  @override
  Widget build(BuildContext context) {
    print('Build is called');
    return Scaffold(
      appBar: AppBar(title: const Text('ScreenB')),
      body: const Center(
        child: Text(
          'ScreenB 페이지',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
