import 'package:flutter/material.dart';
import 'payment1.dart';

void main() {
  runApp(MyApp5());
}

class MyApp5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyApp6(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.fitness_center, color: Colors.orange, size: 40),
                  SizedBox(width: 10),
                  Text(
                    'Fitness & Diet Planner',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Divider(),

            // Payment Methods
            _buildPaymentMethodTile('Debit Card', Icons.circle, Colors.orange),
            Divider(height: 1),

            _buildPaymentMethodTile('Credit Card', Icons.credit_card, Colors.blue),
            Divider(height: 1),

            _buildPaymentMethodTile('PayPal', Icons.account_balance_wallet, Colors.purple),
            Divider(height: 1),

            _buildPaymentMethodTile('UPI', Icons.account_balance, Colors.green),
            Divider(height: 1),

            Spacer(),

            // Checkout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.lock, color: Colors.white),
                  label: Text('Secure Checkout',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Implement secure checkout logic
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(String title, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      onTap: () {
        // Handle tap
      },
    );
  }
}
