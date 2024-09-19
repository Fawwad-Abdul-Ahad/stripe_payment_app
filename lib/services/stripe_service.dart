import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:payment_app/data/const.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      // Create a payment intent
      String? paymentIntent = await createPaymentIntent('10', 'usd');
      if (paymentIntent != null) {
        // Initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent, // Received from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Ikay',
          ),
        );

        // Process the payment
        await processPayment();
      } else {
        print('Payment Intent is null');
      }
    } catch (e) {
      print('Error in makePayment: $e');
    }
  }

  Future<String?> createPaymentIntent(String amount, String currency) async {
    try {
      // Request body for Stripe API
      Map<String, dynamic> body = {
        'amount': createAmount(amount),
        'currency': currency,
      };

      // Sending POST request to Stripe API
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse['client_secret']; // Return the client_secret from the response
      } else {
        print('Error in createPaymentIntent: ${decodedResponse['error']['message']}');
        return null;
      }
    } catch (e) {
      print('Error in createPaymentIntent: $e');
      return null;
    }
  }

  Future<void> processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment successful');
    } catch (e) {
      print('Error in processPayment: $e');
    }
  }

  // Convert the amount to the smallest currency unit (e.g., cents for USD)
  String createAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100).toString();
    return calculatedAmount;
  }
}
