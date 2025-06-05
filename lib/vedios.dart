import 'package:flutter/material.dart';
import 'diet1.dart';

void main() {
  runApp(const MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyApp4(),
    );
  }
}

class AIFitnessPlanPage extends StatelessWidget {
  const AIFitnessPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'AI Fitness Plan\nPersonalized Workout\nplans',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Video Tutorials Button
              buildOptionButton(
                icon: Icons.assignment,
                label: 'Video tutorials',
              ),
              const SizedBox(height: 20),

              // Track Performance Button
              buildOptionButton(
                icon: Icons.play_circle_outline,
                label: 'Track performance\n(reps, sets, duration)',
              ),
              const SizedBox(height: 20),

              // AI Suggestions Button
              buildOptionButton(
                icon: Icons.bar_chart,
                label: 'Option to switch\nAI suggestions',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionButton({required IconData icon, required String label}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
