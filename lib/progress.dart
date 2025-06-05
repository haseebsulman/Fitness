import 'package:flutter/material.dart';
import 'vedios.dart';

void main() => runApp(const MyApp2());

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp3 (),
    );
  }
}

class ProgressTrackerScreen extends StatelessWidget {
  const ProgressTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Progress Tracker',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            _buildSection(title: 'Weight', imagePath: 'assets/images/weight.png'),
            const SizedBox(height: 16),
            _buildSection(title: 'BMI', imagePath: 'assets/images/bmi.png'),
            const SizedBox(height: 16),
            _buildSection(title: 'Steps', imagePath: 'assets/images/steps.png'),
            const SizedBox(height: 16),
            _buildSection(title: 'Calories Burned', imagePath: 'assets/images/bmi.png'),

            const SizedBox(height: 30),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              title: const Text(
                'Upload progress pictures',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle upload
              },
              shape: const Border(
                top: BorderSide(color: Colors.black, width: 1),
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String imagePath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
