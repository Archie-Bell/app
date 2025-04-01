import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SubmissionPage extends StatefulWidget {
  const SubmissionPage({super.key});

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  File? _selectedImage;
  final TextEditingController _textController = TextEditingController();
  String _selectedDate = "Select Date & Time";

  Future _pickImage() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<void> _selectDateTime() async {
    // Show Date Picker
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // If the widget is still mounted (still part of the widget tree), show the Time Picker
    if (selectedDate != null && mounted) {
      // Show Time Picker, using the selected date's time
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate), // Use selectedDate for initial time
      );

      // If the widget is still mounted, proceed with the update
      if (selectedTime != null && mounted) {
        // Combine selected date and time
        DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Format the final DateTime for the backend (ISO 8601 format with milliseconds)
        String backendDateTime = finalDateTime.toIso8601String();

        // Update the state only if the widget is still mounted
        if (mounted) {
          setState(() {
            _selectedDate = backendDateTime; // This will hold the formatted date for backend use
          });
        }
      }
    }
  }

  void _submitForm() {
    // Handle the submit logic here, e.g., save the data or upload to a server.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form Submitted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: Styles.appGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_selectedImage != null)
                    Column(
                      children: [
                        Image.file(
                          File(_selectedImage!.path),
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  const SizedBox(height: 16),

                  // Text Field
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter something',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                  const SizedBox(height: 16),

                  // Prompt user to pick an image
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Image'),
                  ),

                  const SizedBox(height: 16),

                  // Prompt user to pick a date and time
                  ElevatedButton(
                    onPressed: _selectDateTime,
                    child: Text(_selectedDate),
                  ),

                  const SizedBox(height: 16),

                  // Button for submitting data
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}