import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final int id;
  final String author;
  final String image;
  final String publication_date;
  final String title;
  final String text;

  CartItemTile({this.id, this.author, this.image, this.publication_date, this.title, this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
        backgroundImage:
          NetworkImage(publication_date),
        ),
          //title: Text('${title}'),
          title: Text(text),
      ),
    );
  }
}