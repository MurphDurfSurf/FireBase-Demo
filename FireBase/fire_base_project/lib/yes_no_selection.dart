import 'package:flutter/material.dart';
import 'app_state.dart';
import 'src/widgets.dart';

class YesNoSelection extends StatefulWidget {
  const YesNoSelection(
      {super.key, required this.state, required this.onSelection});
  final Attending state;
  final void Function(Attending selection, int? extraAttendees) onSelection;

  @override
  _YesNoSelectionState createState() => _YesNoSelectionState();
}

class _YesNoSelectionState extends State<YesNoSelection> {
  final TextEditingController _attendeesController = TextEditingController();
  int? _extraAttendees;

  void _onYesSelection() {
    widget.onSelection(Attending.yes, _extraAttendees);
  }

  void _onNoSelection() {
    widget.onSelection(Attending.no, null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FilledButton(
                onPressed: _onYesSelection,
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: _onNoSelection,
                child: const Text('NO'),
              ),
            ],
          ),
        ),
        if (widget.state == Attending.yes) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _attendeesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Additional attendees',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _extraAttendees = int.tryParse(value);
                });
              },
            ),
          ),
          if (_extraAttendees == null || _extraAttendees! < 0)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Please enter a valid number of additional attendees.',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ],
    );
  }
}
