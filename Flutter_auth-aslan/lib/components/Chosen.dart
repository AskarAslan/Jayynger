import 'package:flutter/material.dart';
import 'package:flutter_app/models/cart_item_tile.dart';
import 'package:flutter_app/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Chosen extends StatefulWidget {
  const Chosen({Key key}) : super(key: key);

  @override
  _ChosenState createState() => _ChosenState();
}

class _ChosenState extends State<Chosen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItems>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) =>
                    CartItemTile(
                      text: cart.items.values.toList()[i].text.toString(),
                      title: cart.items.values.toList()[i].title.toString(),
                      publication_date: cart.items.values.toList()[i].publication_date,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
