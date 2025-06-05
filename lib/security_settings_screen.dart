import 'package:flutter/material.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricAuthEnabled = false;
  bool _twoFactorAuthEnabled = true;
  bool _passwordVisibility = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Account Security',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Change Password
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showChangePasswordDialog(context);
            },
          ),
          const Divider(height: 1),

          // Biometric Authentication
          SwitchListTile(
            title: const Text('Biometric Authentication'),
            subtitle: const Text('Use fingerprint or face recognition'),
            value: _biometricAuthEnabled,
            onChanged: (value) {
              setState(() {
                _biometricAuthEnabled = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Biometric authentication ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
          const Divider(height: 1),

          // Two-Factor Authentication
          SwitchListTile(
            title: const Text('Two-Factor Authentication'),
            subtitle: const Text('Extra layer of security for your account'),
            value: _twoFactorAuthEnabled,
            onChanged: (value) {
              setState(() {
                _twoFactorAuthEnabled = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Two-factor authentication ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),

          const SizedBox(height: 30),
          const Text(
            'Security Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Recent Activity
          ListTile(
            title: const Text('Recent Security Activity'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Showing recent security activity')),
              );
            },
          ),
          const Divider(height: 1),

          // Connected Devices
          ListTile(
            title: const Text('Connected Devices'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Showing connected devices')),
              );
            },
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: !_passwordVisibility,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisibility ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisibility = !_passwordVisibility;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Password must be at least 8 characters'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_passwordController.text.length >= 8) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password must be at least 8 characters')),
                  );
                }
              },
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
  }
}