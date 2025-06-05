import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _pushEnabled = true;
  bool _emailEnabled = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  String _priority = 'High';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Notification Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Push Notifications Switch
          SwitchListTile(
            title: const Text('Enable Push Notifications'),
            value: _pushEnabled,
            onChanged: (value) => setState(() => _pushEnabled = value),
          ),

          // Email Notifications Switch
          SwitchListTile(
            title: const Text('Enable Email Notifications'),
            value: _emailEnabled,
            onChanged: (value) => setState(() => _emailEnabled = value),
          ),

          const Divider(height: 30),
          const Text(
            'Notification Style',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),

          // Sound Switch
          SwitchListTile(
            title: const Text('Play Sound'),
            value: _soundEnabled,
            onChanged: _pushEnabled
                ? (value) => setState(() => _soundEnabled = value)
                : null,
          ),

          // Vibration Switch
          SwitchListTile(
            title: const Text('Enable Vibration'),
            value: _vibrationEnabled,
            onChanged: _pushEnabled
                ? (value) => setState(() => _vibrationEnabled = value)
                : null,
          ),

          // Priority Dropdown
          ListTile(
            title: const Text('Notification Priority'),
            trailing: DropdownButton<String>(
              value: _priority,
              items: const [
                DropdownMenuItem(value: 'High', child: Text('High')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'Low', child: Text('Low')),
              ],
              onChanged: _pushEnabled
                  ? (value) => setState(() => _priority = value!)
                  : null,
            ),
          ),

          const Divider(height: 30),
          ElevatedButton(
            onPressed: () {
              // Save settings logic here
              Navigator.pop(context);
            },
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }
}