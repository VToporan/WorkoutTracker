import 'package:GainsTrack/components/slidable_componenet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jiffy/jiffy.dart';

import '../storage/exercise_data_storage.dart';
import 'modal_component.dart';

class NotesComponent extends StatefulWidget {
  final ExerciseData currentExercise;

  const NotesComponent({super.key, required this.currentExercise});

  @override
  State<NotesComponent> createState() => _NotesComponentState();
}

class _NotesComponentState extends State<NotesComponent> {
  @override
  Widget build(BuildContext context) {
    widget.currentExercise.logData.sort((b, a) => a.date.compareTo(b.date));
    return SlidableAutoCloseBehavior(
      child: Column(
        children: widget.currentExercise.logData
            .map(
              (currentLog) => SlidableComponent(
                key: ValueKey(currentLog.id),
                cardTitle: currentLog.note,
                cardSubtitle: Jiffy(currentLog.date).format('MMMM do yyyy'),
                onTap: (() => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ModalComponent(
                        inputs: [],
                        onSubmit: () {},
                      );
                    })),
                onDelete: ((context) {
                  setState(() {
                    widget.currentExercise.logData.remove(currentLog);
                  });
                }),
              ),
            )
            .toList(),
      ),
    );
  }
}
