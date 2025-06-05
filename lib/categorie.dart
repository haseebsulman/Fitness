import 'package:flutter/material.dart';
import 'diet.dart';
import 'edit_options_screen.dart'; // Add this import

void main() {
  runApp(FitnessPlannerApp());
}

class FitnessPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: FitnessHomePage(),
    );
  }
}

class FitnessHomePage extends StatefulWidget {
  @override
  _FitnessHomePageState createState() => _FitnessHomePageState();
}

class _FitnessHomePageState extends State<FitnessHomePage> {
  String? selectedCategory;

  final List<Map<String, String>> schedule = [
    {'day': 'Monday', 'plan': 'Full Body'},
    {'day': 'Tuesday', 'plan': 'Lower Body'},
    {'day': 'Wednesday', 'plan': 'Rest day'},
    {'day': 'Thursday', 'plan': 'Upper Body'},
    {'day': 'Friday', 'plan': 'Rest day'},
  ];

  final List<Map<String, dynamic>> categories = [
    {
      'label': 'Weight Loss',
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
      'description': 'Burn calories and lose weight'
    },
    {
      'label': 'Muscle Gain',
      'icon': Icons.fitness_center,
      'color': Colors.blue,
      'description': 'Build strength and muscle mass'
    },
    {
      'label': 'Yoga',
      'icon': Icons.self_improvement,
      'color': Colors.purple,
      'description': 'Improve flexibility and mindfulness'
    },
    {
      'label': 'Custom Plan',
      'icon': Icons.build,
      'color': Colors.green,
      'description': 'Create your personalized workout'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[600]!, Colors.blue[400]!],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Fitness Planner',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Choose your fitness goal',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Weekly Schedule Section
                    Text(
                      'Weekly Schedule',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 15),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: schedule.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: item['plan'] == 'Rest day'
                                      ? Colors.grey[400]
                                      : Colors.blue[400],
                                ),
                              ),
                              SizedBox(width: 15),
                              Text(
                                item['day']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: item['plan'] == 'Rest day'
                                      ? Colors.grey[100]
                                      : Colors.blue[50],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item['plan']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: item['plan'] == 'Rest day'
                                        ? Colors.grey[600]
                                        : Colors.blue[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Categories Section
                    Text(
                      'Choose Your Goal',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 15),

                    // Category Cards
                    ...categories.map((category) => _buildCategoryCard(category)).toList(),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Buttons
            if (selectedCategory != null)
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _navigateToDietScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _navigateToEditOptions,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    bool isSelected = selectedCategory == category['label'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category['label'];
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? category['color'] : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? category['color'].withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: isSelected ? 2 : 1,
              blurRadius: isSelected ? 15 : 10,
              offset: Offset(0, isSelected ? 5 : 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: category['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                category['icon'] as IconData,
                size: 30,
                color: category['color'],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    category['description'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: category['color'],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                ),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToDietScreen() {
    if (selectedCategory == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $selectedCategory'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DietPlanApp(selectedCategory: selectedCategory),
      ),
    );
  }

  void _navigateToEditOptions() {
    if (selectedCategory == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditOptionsScreen(),
      ),
    );
  }
}