import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe Payment"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () async {
                await makePayment();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Center(
                  child: Text(
                      "Payment",
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }


    Future<void> makePayment() async{
      try {
        paymentIntentData = await createPaymentIntent('20', 'USD');
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              style: ThemeMode.dark,
              marchantCountryCode: 'US',
              merchantDisplayName: 'ASIF',
            )
        );

        displayPaymentSheet() async {
          try {

            Stripe.instance.presentPaymentSheet(
              clientSecret: paymentIntentData!['Client_secret'],
              confirmPayment: true,
            );
            setState(() {
              paymentIntentData = null;
            });

            ScaffoldMessenger.of(context).
            showSnackBar(SnackBar(content: Text("Paid Successfully")));
          } on StripeException catch (e) {
            print(e.toString());
          }
          }
        }
    }
  }

  createPaymentIntent(String amount, String currency) async {

    try {

      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_type[]': 'card'
      };

      var response = await http.post(Uri.parse('')),
      body: body,
       headers: {
        'Authorization': '';
        'Content-Type': '';
    });
    return jsonDecode(response.body.toString());

    }catch(e) {
      print('exception'+e.toString());
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price;
  }
}