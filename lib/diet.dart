import 'package:flutter/material.dart';

class DietPlanApp extends StatelessWidget {
  final String? selectedCategory;

  const DietPlanApp({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define meal plans for each category
    final Map<String, List<String>> mealPlans = {
      'Weight Loss': [
        'Breakfast: Oatmeal with berries',
        'Snack: Greek yogurt with almonds',
        'Lunch: Grilled chicken salad',
        'Snack: Vegetable sticks with hummus',
        'Dinner: Baked salmon with quinoa'
      ],
      'Muscle Gain': [
        'Breakfast: Scrambled eggs with whole wheat toast',
        'Snack: Protein shake with banana',
        'Lunch: Lean beef with brown rice',
        'Snack: Cottage cheese with nuts',
        'Dinner: Grilled chicken with sweet potatoes'
      ],
      'Yoga': [
        'Breakfast: Fruit smoothie with chia seeds',
        'Snack: Handful of mixed nuts',
        'Lunch: Quinoa salad with avocado',
        'Snack: Herbal tea with dates',
        'Dinner: Lentil soup with whole grain bread'
      ],
      'Custom Plan': [
        'Breakfast: Customize based on your preferences',
        'Snack: Choose healthy options',
        'Lunch: Balanced meal with protein and carbs',
        'Snack: Light and nutritious',
        'Dinner: Tailored to your fitness goals'
      ],
    };

    final meals = mealPlans[selectedCategory] ?? [
      'Breakfast: Balanced meal',
      'Snack: Healthy option',
      'Lunch: Protein with vegetables',
      'Snack: Light nutrition',
      'Dinner: Well-rounded meal'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$selectedCategory Diet Plan'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 50,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your $selectedCategory Meal Plan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ...meals.map((meal) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              meal,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Back to Fitness Planner',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}