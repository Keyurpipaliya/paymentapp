import 'package:flutter/material.dart';
import 'package:payment/Upi_Payment_screen.dart';

class UpiPaymentScreen extends StatelessWidget {
  const UpiPaymentScreen({super.key});

  @override
  _UpiPaymentScreenState createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  Future<UpiResponce>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then(value) {
      setState(() {
        apps = value;
      });
    }).catchEror(e) {
      print(e);
      apps = [];
    });
    super.initState();
  }

  Future<UpiApp> initiateTransaction(UpiApp app) async {
    Widget displayUpiApps() {
      if (apps == null) {
        return const Center(child: CircularProgressIndicator());
      } else if (apps!isEmpty) {
        return Center(
          child: Text(
            "No apps found to handle transaction"
            style: header,
          ),
        );
      } else {
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Wrap(
                children: apps!.map<Widget>(UpiApp app) {
            }
            ),
          ),
        );
      }
    }
  }
}