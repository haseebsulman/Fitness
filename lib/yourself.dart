import 'package:flutter/material.dart';
import 'goal.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String? _selectedGender;
  String? _selectedHeight;
  String? _selectedWeight;

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> heightOptions = [
    for (int i = 120; i <= 220; i += 5) '$i cm'
  ];
  final List<String> weightOptions = [
    for (int i = 40; i <= 150; i += 5) '$i kg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Progress bar
              LinearProgressIndicator(
                value: 0.66,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
                minHeight: 5,
              ),

              const SizedBox(height: 30),

              // Title
              const Text(
                "Tell us about yourself",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Gender dropdown
              _buildDropdown(
                label: "Gender",
                value: _selectedGender,
                items: genderOptions,
                onChanged: (value) => setState(() => _selectedGender = value),
              ),

              const SizedBox(height: 16),

              // Height dropdown
              _buildDropdown(
                label: "170 cm",
                value: _selectedHeight,
                items: heightOptions,
                onChanged: (value) => setState(() => _selectedHeight = value),
              ),

              const SizedBox(height: 16),

              // Weight dropdown
              _buildDropdown(
                label: "65 kg",
                value: _selectedWeight,
                items: weightOptions,
                onChanged: (value) => setState(() => _selectedWeight = value),
              ),

              const SizedBox(height: 30),

              // Illustration (replace with your asset)
              Image.asset(
                'assets/images/person.png',
                height: 180,
              ),

              const Spacer(),

              // Next button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedGender == null ||
                        _selectedHeight == null ||
                        _selectedWeight == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please complete all fields')),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoalSelectionScreen()),
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
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(label),
        isExpanded: true,
        underline: SizedBox(),
        items: items
            .map((item) =>
            DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
