import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/screenB');
                },
                child: const Text('Screen B로 이동')),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/screenC');
                },
                child: const Text('Screen C로 이동')),
          ],
        ),
      ),
    );
  }
}
