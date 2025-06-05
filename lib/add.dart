import 'package:flutter/material.dart';
import 'feedback.dart';

void main() => runApp(const MyApp8());

class MyApp8 extends StatelessWidget {
  const MyApp8({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FeedbackApp(),
    );
  }
}

// User model
class User {
  String name;
  String age;
  String phone;
  String email;
  String goal;
  String address;

  User({
    required this.name,
    required this.age,
    required this.phone,
    required this.email,
    required this.goal,
    required this.address,
  });
}

class EditOptionsScreen extends StatefulWidget {
  const EditOptionsScreen({super.key});

  @override
  State<EditOptionsScreen> createState() => _EditOptionsScreenState();
}

class _EditOptionsScreenState extends State<EditOptionsScreen> {
  List<User> users = [];

  // Show form to add/edit user
  void _showUserForm({User? user, int? index}) {
    final nameController = TextEditingController(text: user?.name ?? '');
    final ageController = TextEditingController(text: user?.age ?? '');
    final phoneController = TextEditingController(text: user?.phone ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');
    final goalController = TextEditingController(text: user?.goal ?? '');
    final addressController = TextEditingController(text: user?.address ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(user == null ? "Add User" : "Edit User"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              TextField(controller: ageController, decoration: const InputDecoration(labelText: "Age")),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: goalController, decoration: const InputDecoration(labelText: "Fitness Goal")),
              TextField(controller: addressController, decoration: const InputDecoration(labelText: "Address")),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty) return;

              final newUser = User(
                name: nameController.text.trim(),
                age: ageController.text.trim(),
                phone: phoneController.text.trim(),
                email: emailController.text.trim(),
                goal: goalController.text.trim(),
                address: addressController.text.trim(),
              );

              setState(() {
                if (user == null) {
                  users.add(newUser);
                } else {
                  users[index!] = newUser;
                }
              });

              Navigator.pop(context);
            },
            child: Text(user == null ? "Add" : "Save"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // Delete user
  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete User"),
        content: Text("Are you sure you want to delete '${users[index].name}'?"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                users.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
        ],
      ),
    );
  }

  // Main screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Manager'),
      ),
      body: Column(
        children: [
          Expanded(
            child: users.isEmpty
                ? const Center(child: Text("No users yet."))
                : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Age: ${user.age}"),
                        Text("Phone: ${user.phone}"),
                        Text("Email: ${user.email}"),
                        Text("Goal: ${user.goal}"),
                        Text("Address: ${user.address}"),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showUserForm(user: user, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteUser(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showUserForm(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add User'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}