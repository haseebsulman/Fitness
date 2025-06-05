import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = '';

  Widget _buildCreditCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(decoration: InputDecoration(labelText: "Card Number")),
        const TextField(decoration: InputDecoration(labelText: "Card Holder Name")),
        const Row(
          children: [
            Expanded(child: TextField(decoration: InputDecoration(labelText: "Expiry Date"))),
            SizedBox(width: 16),
            Expanded(child: TextField(decoration: InputDecoration(labelText: "CVV"))),
          ],
        ),
      ],
    );
  }

  Widget _buildPayPalForm() {
    return const TextField(decoration: InputDecoration(labelText: "PayPal Email"));
  }

  Widget _buildGooglePayForm() {
    return const TextField(decoration: InputDecoration(labelText: "Google Account Email"));
  }

  Widget _buildSelectedForm() {
    switch (selectedMethod) {
      case 'Credit/Debit Card':
        return _buildCreditCardForm();
      case 'PayPal':
        return _buildPayPalForm();
      case 'Google Pay':
        return _buildGooglePayForm();
      default:
        return const SizedBox();
    }
  }

  Widget _buildPaymentOption(String method, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(method),
      trailing: selectedMethod == method ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Payment Method')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPaymentOption("Credit/Debit Card", Icons.credit_card),
            _buildPaymentOption("PayPal", Icons.account_balance_wallet),
            _buildPaymentOption("Google Pay", Icons.payment),
            const SizedBox(height: 20),
            if (selectedMethod.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter $selectedMethod details", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildSelectedForm(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Handle payment confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Payment processed")),
                      );
                    },
                    child: const Text("Confirm Payment"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
