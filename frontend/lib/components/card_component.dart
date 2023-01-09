import 'package:GainsTrack/components/modal_component.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function() onTap;

  const CardComponent({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
