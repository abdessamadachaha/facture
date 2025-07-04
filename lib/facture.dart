import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/item.dart';
import 'package:flutter_application_1/product.dart';
import 'package:flutter_application_1/total.dart';
import 'package:flutter_application_1/widget/input.dart';
import 'package:intl/intl.dart';

class Facture extends StatefulWidget {
  const Facture({super.key});

  @override
  State<Facture> createState() => _FactureState();
}

class _FactureState extends State<Facture> {
  TextEditingController _controller1 = TextEditingController(); // Nom
  TextEditingController _controller2 = TextEditingController(); // Email
  DateTime? selectDate;

  List<ArticleItem> articles = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialDate: selectDate ?? DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        selectDate = picked;
      });
    }
  }

  double get totalHT => articles.fold(0, (sum, item) => sum + item.total);
  double get tva => totalHT * 0.20;
  double get totalTTC => totalHT + tva;

  @override
  Widget build(BuildContext context) {
    String buttonText = selectDate == null
        ? 'Sélectionnez une date'
        : DateFormat.yMMMMd('en_US').format(selectDate!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Créer une nouvelle facture', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Input(controller: _controller1, name: 'Nom du client', type: TextInputType.name),
            SizedBox(height: 20),
            Input(controller: _controller2, name: 'Email du client', type: TextInputType.emailAddress),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                onPressed: () => _selectDate(context),
                child: Text('Date de facture : $buttonText', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Product()),
                  );
                  if (result != null && result is ArticleItem) {
                    setState(() {
                      articles.add(result);
                    });
                  }
                },
                child: Text('Ajouter un article', style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: articles.isEmpty
                  ? Center(child: Text("Aucun article ajouté"))
                  : ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final item = articles[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(item.description),
                            subtitle: Text("${item.quantity} × ${item.price.toStringAsFixed(2)} DH"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${item.total.toStringAsFixed(2)} DH"),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      articles.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total HT :"),
                      Text("${totalHT.toStringAsFixed(2)} DH"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("TVA (20%) :"),
                      Text("${tva.toStringAsFixed(2)} DH"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total TTC :"),
                      Text("${totalTTC.toStringAsFixed(2)} DH"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

           ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)
              )),
              onPressed: () {
                if (_controller1.text.isNotEmpty &&
                    _controller2.text.isNotEmpty &&
                    selectDate != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Total(
                        name: _controller1.text,
                        email: _controller2.text,
                        date: selectDate!,
                        articles: articles,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez remplir tous les champs.")),
                  );
                }
              },
              child: Text('Aperçu de la facture', style: TextStyle(color: Colors.white)),
            )

          ],
        ),
      ),
    );
  }
}
