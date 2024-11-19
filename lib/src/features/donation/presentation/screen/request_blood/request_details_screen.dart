import 'package:blood_donation/src/features/donation/data/model/user_request_model.dart';
import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key, required this.userRequest});

  final UserRequestModel userRequest;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                        'Patient Name: ${widget.userRequest.request.patientName}'),
                    const SizedBox(height: 16),
                    Text('Blood Type: ${widget.userRequest.request.bloodType}'),
                    const SizedBox(height: 16),
                    Text('Location: ${widget.userRequest.request.location}'),
                    const SizedBox(height: 16),
                    Text(
                        'Requested by: ${widget.userRequest.user.firstName} ${widget.userRequest.user.lastName}'),
                    const SizedBox(height: 16),
                    Text('Problem: ${widget.userRequest.request.note}')
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  color: Colors.redAccent.withOpacity(.9),
                ),
                child: const Center(
                  child: Text(
                    'Donate',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
