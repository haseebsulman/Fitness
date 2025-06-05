import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerified();
  }

  Future<void> _checkEmailVerified() async {
    await _auth.currentUser?.reload();
    setState(() {
      isEmailVerified = _auth.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _resendVerificationEmail() async {
    setState(() => isLoading = true);
    try {
      await _auth.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification email resent.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send verification email.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Your Email')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'A verification email has been sent to your email address. '
                  'Please check your inbox and click the verification link.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checkEmailVerified,
              child: const Text('I have verified'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _resendVerificationEmail,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Resend Verification Email'),
            ),
          ],
        ),
      ),
    );
  }
}
