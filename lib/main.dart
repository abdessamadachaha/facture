import 'package:flutter/material.dart';
import 'package:flutter_application_1/facture.dart';
import 'package:flutter_application_1/product.dart';

void main() => runApp(app());

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Facture(),
    );
  }
}