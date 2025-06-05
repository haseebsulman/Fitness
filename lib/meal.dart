import 'package:flutter/material.dart';
import 'progress.dart';

void main() {
  runApp(MealDetailApp());
}

class MealDetailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Detail',
      debugShowCheckedModeBanner: false,
      home: MyApp2 (),
    );
  }
}

class MealDetailScreen extends StatelessWidget {
  final List<String> ingredients = [
    '2 Eggs',
    '1 cup spinach',
    '1 tbps olive oil',
    'salt to taste',
  ];

  final List<String> steps = [
    'Heat olive oil in a pan.',
    'Crack eggs into the pan.',
    'Cook until whites are set.',
    'Add salt and serve hot.',
  ];

  final List<String> alternativeMeals = [
    'Avocado Toast',
    'Protein',
    'Shake',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Meal Detail',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Ingredients
              Text(
                'Ingredients',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...ingredients.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(Icons.sports_basketball, size: 18),
                    SizedBox(width: 8),
                    Expanded(child: Text(item)),
                  ],
                ),
              )),
              SizedBox(height: 20),

              // Steps
              Text(
                'Steps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...steps.asMap().entries.map((entry) {
                int idx = entry.key + 1;
                String step = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black,
                        child: Text(
                          '$idx',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(child: Text(step)),
                    ],
                  ),
                );
              }),
              SizedBox(height: 20),

              // Alternative Meals
              Text(
                'Alternative Meals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 10,
                children: alternativeMeals.map((meal) {
                  return Chip(
                    label: Text(meal),
                    backgroundColor: Colors.grey.shade300,
                  );
                }).toList(),
              ),
              SizedBox(height: 30),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                    label: Text('Add to Favorite'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: StadiumBorder(),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.compare_arrows),
                    label: Text('Replace'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
