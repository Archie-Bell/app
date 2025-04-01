import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

    // Show Time Picker
    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (selectedTime != null) {
        setState(() {
          _selectedDate =
              '${DateFormat('yyyy-MM-dd').format(selectedDate)} ${selectedTime.format(context)}';
        });
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

                  // TODO: specific time modification required
                  // Prompt user to pick a date
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
