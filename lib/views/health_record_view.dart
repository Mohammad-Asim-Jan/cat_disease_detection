import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/health_record_model.dart';

class HealthRecordsView extends StatefulWidget {
  const HealthRecordsView({super.key});

  @override
  State<HealthRecordsView> createState() => _HealthRecordsViewState();
}

class _HealthRecordsViewState extends State<HealthRecordsView> {
  final List<HealthRecord> _records = [];

  // For calendar appointments
  Map<DateTime, List<String>> _appointments = {};

  // Controller to manage new health entries
  final TextEditingController _scanController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Past Health Records',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // List of past health records
            _records.isEmpty
                ? const Center(
                    child: Text('No health records available.'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _records.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title:
                              Text('Diagnosis: ${_records[index].diagnosis}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Scan: ${_records[index].scan}'),
                              Text('Treatment: ${_records[index].treatment}'),
                              Text('Date: ${_records[index].date.toLocal()}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 24),

            // Section to add new health records
            const Text(
              'Add New Health Record',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildHealthForm(),
            const SizedBox(height: 24),

            // Calendar for appointments
            const Text(
              'Appointments & Medications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildCalendar(),
          ],
        ),
      ),
    );
  }

  // Widget for the form to add new health records
  Widget _buildHealthForm() {
    return Column(
      children: [
        TextField(
          controller: _scanController,
          decoration: const InputDecoration(
            labelText: 'Scan',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _diagnosisController,
          decoration: const InputDecoration(
            labelText: 'Diagnosis',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _treatmentController,
          decoration: const InputDecoration(
            labelText: 'Treatment',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addNewRecord,
          child: const Text('Add Record'),
        ),
      ],
    );
  }

  // Function to add a new health record
  void _addNewRecord() {
    setState(() {
      _records.add(
        HealthRecord(
          date: DateTime.now(),
          scan: _scanController.text,
          diagnosis: _diagnosisController.text,
          treatment: _treatmentController.text,
        ),
      );
      // Clear the form fields
      _scanController.clear();
      _diagnosisController.clear();
      _treatmentController.clear();
    });
  }

  // Widget for calendar view
  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 1, 1),
      eventLoader: (day) => _appointments[day] ?? [],
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        _addAppointment(selectedDay);
      },
    );
  }

  // Function to add a new appointment to the calendar
  void _addAppointment(DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _appointmentController =
            TextEditingController();
        return AlertDialog(
          title: const Text('Add Appointment'),
          content: TextField(
            controller: _appointmentController,
            decoration: const InputDecoration(
              labelText: 'Appointment/Medication',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_appointments[selectedDay] != null) {
                    _appointments[selectedDay]!
                        .add(_appointmentController.text);
                  } else {
                    _appointments[selectedDay] = [_appointmentController.text];
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
