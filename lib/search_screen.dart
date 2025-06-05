import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search workouts, meals, etc...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.fitness_center),
                    title: Text('Workout Plans'),
                    subtitle: Text('Browse all workout plans'),
                  ),
                  ListTile(
                    leading: Icon(Icons.restaurant),
                    title: Text('Meal Recipes'),
                    subtitle: Text('Find healthy recipes'),
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Trainers'),
                    subtitle: Text('Connect with professionals'),
                  ),
                  ListTile(
                    leading: Icon(Icons.article),
                    title: Text('Articles'),
                    subtitle: Text('Read fitness articles'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}