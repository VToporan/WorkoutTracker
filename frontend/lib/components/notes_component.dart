import 'package:GainsTrack/components/input_components.dart';
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
  late NumberInputComponent setsInput;
  late NumberInputComponent repsInput;
  late NumberInputComponent weightInput;
  late LongInputComponent notesInput;
  late DateInputComponent dateInput;

  late List<InputComponent> inputs;

  String errorMessage = "";
  bool isError = false;
  GlobalKey<ModalComponentState> modalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    widget.currentExercise.logData.sort((b, a) => a.date.compareTo(b.date));
    return SlidableAutoCloseBehavior(
      child: Column(
        children: widget.currentExercise.logData.map((currentLog) {
          return SlidableComponent(
            key: ValueKey(currentLog.id),
            cardTitle: currentLog.note,
            cardSubtitle: Jiffy(currentLog.date).format('MMMM do yyyy'),
            onTap: (() => showDialog(
                context: context,
                builder: (BuildContext context) {
                  setAllControllers(currentLog);
                  return ModalComponent(
                    key: modalKey,
                    title: "Edit exercise log",
                    inputs: inputs,
                    onSubmit: () {
                      resetError();
                      verifyInputsNotEmpty();
                      if (isError) {
                        modalKey.currentState!.setErrorMessage("Invalid Input");
                      }
                    },
                  );
                })),
            onDelete: ((context) {
              setState(() {
                widget.currentExercise.logData.remove(currentLog);
              });
            }),
          );
        }).toList(),
      ),
    );
  }

  void setAllControllers(LogData currentLog) {
    setsInput = NumberInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(text: currentLog.sets.toString()),
      labelText: "Sets",
    );

    repsInput = NumberInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(text: currentLog.reps.toString()),
      labelText: "Reps",
    );
    weightInput = NumberInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController:
          TextEditingController(text: currentLog.weight.toString()),
      labelText: "Weight",
    );
    notesInput = LongInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(text: currentLog.note),
      labelText: "Notes",
    );

    dateInput = DateInputComponent(
        key: GlobalKey<InputComponentState>(),
        inputController:
            TextEditingController(text: formatDate(currentLog.date)),
        labelText: "Date");

    inputs = [
      setsInput,
      repsInput,
      weightInput,
      notesInput,
      dateInput,
    ];
  }

  String formatDate(DateTime date) {
    return Jiffy(date).format('yyyy-MM-dd');
  }

  void verifyInputsNotEmpty() {
    for (InputComponent input in inputs) {
      if (input is! LongInputComponent) {
        if (input.key.currentState!.isEmpty()) {
          setState(() {
            isError = true;
          });
        }
      }
    }
  }

  void resetError() {
    setState(() {
      isError = false;
      errorMessage = "";
    });
  }
}
