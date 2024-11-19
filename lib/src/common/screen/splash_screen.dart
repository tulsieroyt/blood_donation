import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            //Logo will be here

            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/logo/logo.png'),
            ),

            const Spacer(),

            const SizedBox(
              height: 100,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Version: 1.0.0')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
