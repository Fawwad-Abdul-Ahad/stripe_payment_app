import 'package:flutter/material.dart';
import 'package:payment_app/services/stripe_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Cart Page '),
        centerTitle: true,
      ),
      body: Center(child: InkWell(
        onTap: (){
          StripeService.instance.makePayment();
        },
        child: Container(
          width:200,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
            
          ),
          child: Center(child: Text("Purchase",style: TextStyle(color: Colors.white,fontSize: 22),)),
        ),
      )),
    );
  }
}