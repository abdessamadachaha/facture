import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/item.dart';
import 'package:flutter_application_1/widget/input.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
    List<ArticleItem> articles = [];
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  var result = '0.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Ajouter un Article', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Input(
              controller: _controller1,
              name: 'Description',
              type: TextInputType.text,
            ),
            SizedBox(height: 20),
            Input(
              controller: _controller2,
              name: 'Quantité',
              type: TextInputType.number,
            ),
            SizedBox(height: 20),
            Input(
              controller: _controller3,
              name: 'Prix ​​HT',
              type: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),

            

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              onPressed: () {
  if (_controller1.text.isNotEmpty &&
      _controller2.text.isNotEmpty &&
      _controller3.text.isNotEmpty) {
    final item = ArticleItem(
      description: _controller1.text,
      quantity: int.parse(_controller2.text),
      price: double.parse(_controller3.text),
    );
    Navigator.pop(context, item); 
  }
},

              child: Text('Ajouter un article', style: TextStyle(color: Colors.white)),
            ),

              SizedBox(
              height: 250,
            ),


            
          ],
        ),
      ),
    );
  }
}
