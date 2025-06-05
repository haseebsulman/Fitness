import 'package:flutter/material.dart';
import 'payment.dart';

void main() {
  runApp(const MyApp4());
}

class MyApp4 extends StatelessWidget {
  const MyApp4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyApp5(),
    );
  }
}

class AIDietPlanPage extends StatelessWidget {
  const AIDietPlanPage({super.key});

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
                'AI Diet Plan\nDaily meals (Break-\nfast, Lunch, Dinner)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Daily Meals Button
              buildOptionButton(
                icon: Icons.restaurant_menu,
                label: 'Daily meals\n(Breakfast, Lunch,\nDinner, Snacks)',
              ),
              const SizedBox(height: 20),

              // Ingredients + Cooking Method
              buildOptionButton(
                icon: Icons.playlist_add,
                label: 'Ingredients list\n+ cooking method',
              ),
              const SizedBox(height: 20),

              // Nutritional Information
              buildOptionButton(
                icon: Icons.sync,
                label: 'Nutritional\ninformation\nbreakdown',
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
