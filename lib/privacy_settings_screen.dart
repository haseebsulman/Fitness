import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _activityStatusVisible = true;
  bool _readReceiptsEnabled = true;
  bool _locationSharingEnabled = false;
  bool _dataCollectionAllowed = false;
  String _profileVisibility = 'Friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Profile Privacy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Profile Visibility
          ListTile(
            title: const Text('Profile Visibility'),
            trailing: DropdownButton<String>(
              value: _profileVisibility,
              items: const [
                DropdownMenuItem(value: 'Public', child: Text('Public')),
                DropdownMenuItem(value: 'Friends', child: Text('Friends')),
                DropdownMenuItem(value: 'Only Me', child: Text('Only Me')),
              ],
              onChanged: (value) {
                setState(() {
                  _profileVisibility = value!;
                });
              },
            ),
          ),
          const Divider(height: 1),

          // Activity Status
          SwitchListTile(
            title: const Text('Show Activity Status'),
            subtitle: const Text('Let others see when you\'re active'),
            value: _activityStatusVisible,
            onChanged: (value) {
              setState(() {
                _activityStatusVisible = value;
              });
            },
          ),

          const SizedBox(height: 24),
          const Text(
            'Messaging Privacy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Read Receipts
          SwitchListTile(
            title: const Text('Read Receipts'),
            subtitle: const Text('Let others know when you\'ve read their messages'),
            value: _readReceiptsEnabled,
            onChanged: (value) {
              setState(() {
                _readReceiptsEnabled = value;
              });
            },
          ),

          const SizedBox(height: 24),
          const Text(
            'Location & Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Location Sharing
          SwitchListTile(
            title: const Text('Location Sharing'),
            subtitle: const Text('Allow apps to access your location'),
            value: _locationSharingEnabled,
            onChanged: (value) {
              setState(() {
                _locationSharingEnabled = value;
              });
            },
          ),
          const Divider(height: 1),

          // Data Collection
          SwitchListTile(
            title: const Text('Data Collection'),
            subtitle: const Text('Allow anonymous data collection to improve services'),
            value: _dataCollectionAllowed,
            onChanged: (value) {
              setState(() {
                _dataCollectionAllowed = value;
              });
            },
          ),

          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Save privacy settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy settings saved')),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Save Changes'),
          ),

          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _showPrivacyPolicy(context);
            },
            child: const Text('View Full Privacy Policy'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Last Updated: January 2023',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'We respect your privacy and are committed to protecting your personal data. '
                      'This privacy policy will inform you about how we look after your personal data '
                      'when you use our application and tell you about your privacy rights.',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 16),
                Text(
                  '1. Data We Collect\n'
                      '2. How We Use Your Data\n'
                      '3. Data Security\n'
                      '4. Your Legal Rights\n'
                      '5. Third-Party Services',
                  style: TextStyle(height: 1.8),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full privacy policy
                Navigator.pop(context);
              },
              child: const Text('View Complete Policy'),
            ),
          ],
        );
      },
    );
  }
}