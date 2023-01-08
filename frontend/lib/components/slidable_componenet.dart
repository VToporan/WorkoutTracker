import 'package:GainsTrack/components/card_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableComponent extends StatelessWidget {
  final String cardTitle;
  final String cardSubtitle;
  final Function() onTap;
  final Function() onDelete;

  const SlidableComponent({
    super.key,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        openThreshold: 0.15,
        children: [
          SlidableAction(
            onPressed: onDelete(),
            backgroundColor: Theme.of(context).errorColor,
            foregroundColor: Theme.of(context).primaryColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: CardComponent(id: 0, title: cardTitle, subTitle: cardSubtitle),
    );
  }
}
