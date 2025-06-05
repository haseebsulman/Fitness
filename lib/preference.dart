import 'package:flutter/material.dart';
import 'categorie.dart';

void main() => runApp(const MyApp1());

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FitnessPlannerApp(),
    );
  }
}

class DietaryPreferenceScreen extends StatefulWidget {
  const DietaryPreferenceScreen({super.key});

  @override
  State<DietaryPreferenceScreen> createState() =>
      _DietaryPreferenceScreenState();
}

class _DietaryPreferenceScreenState extends State<DietaryPreferenceScreen> {
  String selectedPreference = "No preference";

  final List<String> options = [
    "No preference",
    "Vegetarian",
    "Vegan",
    "Keto",
    "Paleo",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: 0.25,
                minHeight: 6,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                "Select your\ndietary preferences",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),

              // Chips
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: options.map((option) {
                  final isSelected = selectedPreference == option;
                  return ChoiceChip(
                    label: Text(option),
                    selected: isSelected,
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    side: const BorderSide(color: Colors.grey),
                    onSelected: (_) {
                      setState(() {
                        selectedPreference = option;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // Image
              SizedBox(
                height: 180,
                child: Image.asset('assets/images/diet_image.png'), // Replace with your image
              ),
              const SizedBox(height: 16),

              // Pagination dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == 1 ? 10 : 8,
                    height: index == 1 ? 10 : 8,
                    decoration: BoxDecoration(
                      color: index == 1 ? Colors.indigo : Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FitnessHomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
