import 'package:flutter/material.dart';
import 'preference.dart';

class GoalSelectionScreen extends StatefulWidget {
  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String _selectedGoal = 'Lose weight';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Progress Bar
              LinearProgressIndicator(
                value: 0.2,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
                minHeight: 6,
              ),
              SizedBox(height: 40),

              // Question Text
              Center(
                child: Text(
                  'What is your goal?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Radio Buttons
              _buildRadioOption('Lose weight'),
              _buildRadioOption('Maintain'),
              _buildRadioOption('Gain weight'),

              SizedBox(height: 30),

              // Image
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/goal_image.png',
                    height: 180,
                  ),
                ),
              ),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DietaryPreferenceScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A1B9A),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RadioListTile<String>(
        title: Text(value),
        value: value,
        groupValue: _selectedGoal,
        onChanged: (val) {
          setState(() {
            _selectedGoal = val!;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        tileColor: Colors.grey.shade100,
      ),
    );
  }
}
