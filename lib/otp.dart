import 'package:coffee_shopapp/home_screen.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();
  String enteredOTP = '';

  // Simulate a server-generated OTP for demonstration purposes
  final String serverGeneratedOTP = '123456';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                validateOTP(context); // Pass the context to the function
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void validateOTP(BuildContext context) {
    setState(() {
      enteredOTP = otpController.text;
    });

    // Simulate server-side OTP validation
    if (enteredOTP == serverGeneratedOTP) {
      // Navigate to the next screen upon successful verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CoffeeScreen()), // Replace 'NextScreen' with your desired screen
      );
    } else {
      // Display an error message or retry option
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please enter a valid OTP.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
/*
class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('Welcome to the next screen!'),
      ),
    );
  }
}*/
