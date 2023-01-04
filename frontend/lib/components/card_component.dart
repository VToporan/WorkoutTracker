import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final int id;
  final String title;
  final String subTitle;
  const CardComponent({
    super.key,
    required this.id,
    required this.title,
    required this.subTitle,
  });

  static CardComponent fromJson(json) => CardComponent(
        id: json['id'],
        title: json['title'],
        subTitle: json['subtitle'],
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                subTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
