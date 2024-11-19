import 'package:blood_donation/src/common/widget/app_bar.dart';
import 'package:blood_donation/src/features/donation/presentation/screen/request_blood/request_blood_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BDAppBar(title: 'Report'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => Get.to(const RequestBloodScreen()),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  color: Colors.redAccent.withOpacity(.9),
                ),
                child: const Center(
                  child: Text(
                    'Request for Blood',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
                color: Colors.redAccent.withOpacity(.9),
              ),
              child: const Center(
                child: Text(
                  'Report a Donation',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
