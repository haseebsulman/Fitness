import 'package:flutter/material.dart';
import 'add.dart';

void main() => runApp(const MyApp7());

class MyApp7 extends StatelessWidget {
  const MyApp7({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alerts & Reminders',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: MyApp8(),
    );
  }
}

class Reminder {
  final String id;
  final String title;
  final String time;
  bool isCompleted;
  bool isNotificationOn; // New field

  Reminder({
    required this.id,
    required this.title,
    required this.time,
    this.isCompleted = false,
    this.isNotificationOn = true, // Default ON
  });

  Reminder copyWith({
    String? id,
    String? title,
    String? time,
    bool? isCompleted,
    bool? isNotificationOn,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      isNotificationOn: isNotificationOn ?? this.isNotificationOn,
    );
  }
}

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  List<Reminder> _reminders = [
    Reminder(id: '1', title: 'Supplements', time: '5:00am'),
    Reminder(id: '2', title: 'Lunch', time: '12:00pm', isCompleted: true),
    Reminder(id: '3', title: 'Gym Workout', time: '6:30pm', isCompleted: true),
    Reminder(id: '4', title: 'Bed Time', time: '9:30pm'),
  ];

  void _toggleReminderStatus(String id) {
    setState(() {
      final index = _reminders.indexWhere((reminder) => reminder.id == id);
      if (index != -1) {
        _reminders[index].isCompleted = !_reminders[index].isCompleted;
      }
    });
  }

  void _navigateToEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRemindersScreen(
          reminders: _reminders,
          onRemindersUpdated: (updatedReminders) {
            setState(() {
              _reminders = updatedReminders;
            });
          },
        ),
      ),
    );
  }

  Future<void> _addNewReminder() async {
    final result = await showDialog<Reminder>(
      context: context,
      builder: (context) => const AddEditReminderDialog(),
    );

    if (result != null) {
      setState(() {
        _reminders.add(Reminder(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: result.title,
          time: result.time,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts & Reminders'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              'Notification',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _reminders.length + 1,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index == _reminders.length) {
                  return _buildAddReminderItem();
                }
                return _buildReminderItem(_reminders[index]);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _navigateToEditScreen,
                child: const Text(
                  'Edit Alerts',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderItem(Reminder reminder) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: reminder.isCompleted,
          onChanged: (_) => _toggleReminderStatus(reminder.id),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: '${reminder.time} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: reminder.title),
          ],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Notify'),
          Switch(
            value: reminder.isNotificationOn,
            onChanged: (value) {
              setState(() {
                final index = _reminders.indexWhere((r) => r.id == reminder.id);
                if (index != -1) {
                  _reminders[index].isNotificationOn = value;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddReminderItem() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: const SizedBox(width: 48, height: 48),
      title: const Text(
        'Change reminder Add Reminder',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.add, color: Colors.blue),
        onPressed: _addNewReminder,
      ),
    );
  }
}

class AddEditReminderDialog extends StatefulWidget {
  final String? initialTitle;
  final String? initialTime;

  const AddEditReminderDialog({
    super.key,
    this.initialTitle,
    this.initialTime,
  });

  @override
  State<AddEditReminderDialog> createState() => _AddEditReminderDialogState();
}

class _AddEditReminderDialogState extends State<AddEditReminderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialTitle != null) {
      _titleController.text = widget.initialTitle!;
    }
    if (widget.initialTime != null) {
      _timeController.text = widget.initialTime!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTitle == null ? 'Add New Reminder' : 'Edit Reminder'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Reminder Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Time',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () => _selectTime(context),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a time';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(
                context,
                Reminder(
                  id: '',
                  title: _titleController.text,
                  time: _timeController.text,
                ),
              );
            }
          },
          child: Text(widget.initialTitle == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

class EditRemindersScreen extends StatefulWidget {
  final List<Reminder> reminders;
  final Function(List<Reminder>) onRemindersUpdated;

  const EditRemindersScreen({
    super.key,
    required this.reminders,
    required this.onRemindersUpdated,
  });

  @override
  State<EditRemindersScreen> createState() => _EditRemindersScreenState();
}

class _EditRemindersScreenState extends State<EditRemindersScreen> {
  late List<Reminder> _editableReminders;

  @override
  void initState() {
    super.initState();
    _editableReminders = List.from(widget.reminders);
  }

  void _deleteReminder(int index) {
    setState(() {
      _editableReminders.removeAt(index);
    });
  }

  void _editReminder(int index) async {
    final reminder = _editableReminders[index];
    final result = await showDialog<Reminder>(
      context: context,
      builder: (context) => AddEditReminderDialog(
        initialTitle: reminder.title,
        initialTime: reminder.time,
      ),
    );

    if (result != null) {
      setState(() {
        _editableReminders[index] = reminder.copyWith(
          title: result.title,
          time: result.time,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Alerts'),
        actions: [
          TextButton(
            onPressed: () {
              widget.onRemindersUpdated(_editableReminders);
              Navigator.pop(context);
            },
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _editableReminders.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_editableReminders[index].title),
            subtitle: Text(_editableReminders[index].time),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editReminder(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _deleteReminder(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
