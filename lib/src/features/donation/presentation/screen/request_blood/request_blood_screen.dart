import 'package:blood_donation/src/features/donation/presentation/controller/request_blood_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestBloodScreen extends StatefulWidget {
  const RequestBloodScreen({super.key});

  @override
  State<RequestBloodScreen> createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen> {
  final bloodRequestController = Get.put(RequestBloodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Request for Blood',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: bloodRequestController.requestFromKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: bloodRequestController.patientName,
                  decoration: const InputDecoration(hintText: 'Patient Name'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bloodRequestController.bloodType,
                  decoration: const InputDecoration(hintText: 'Blood Type'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bloodRequestController.location,
                  decoration: const InputDecoration(hintText: 'Location'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bloodRequestController.mobile,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bloodRequestController.problem,
                  decoration: const InputDecoration(hintText: 'Problem'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: ()=> bloodRequestController.createRequest(),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15),
                      color: Colors.redAccent.withOpacity(.9),
                    ),
                    child: const Center(
                      child: Text(
                        'Request',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
