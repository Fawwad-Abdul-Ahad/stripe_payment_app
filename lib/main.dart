import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/data/const.dart';
import 'package:payment_app/screens/payment_screen.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup()async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublicAPI;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: PaymentScreen(),
    );
  }
}
