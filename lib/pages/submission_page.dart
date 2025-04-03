import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/theme.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class SubmissionPage extends StatefulWidget {
  final String missingPersonName;
  final String missingPersonId;

  const SubmissionPage({
    super.key,
    required this.missingPersonName,
    required this.missingPersonId,
  });

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  late String _missingPersonName;
  late String _missingPersonId;
  File? _selectedImage;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  String _selectedDate = "Date & time not yet defined.";
  String _rawSelectedDate = "";

  @override
  void initState() {
    super.initState();
    _missingPersonName = widget.missingPersonName;
    _missingPersonId = widget.missingPersonId;
  }

  Future _pickImage() async {
    try {
      // Show modal to choose between gallery or camera
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Open Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromSource(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Open Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromSource(ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        },
      );
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
    }
  }

  Future _pickImageFromSource(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);

    if (returnedImage == null) return;
    File? img = File(returnedImage.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      _selectedImage = img;
    });
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.indigo,
          toolbarWidgetColor: Colors.indigo.shade50,
          initAspectRatio: CropAspectRatioPreset.square, 
          lockAspectRatio: true, 
          activeControlsWidgetColor: Colors.indigo,
        ),

        IOSUiSettings(
          minimumAspectRatio: 1.0, // Enforce a 1:1 aspect ratio on iOS
        ),
      ]
    );
    
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<void> _selectDateTime() async {
    // Show Date Picker limited to current day and past dates
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // You can adjust this to your needs if you want a limit
      lastDate: DateTime.now(),
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

        // Format the final DateTime for the backend (in the desired format)
        _rawSelectedDate = DateFormat('yyyy-MM-ddTHH:mm').format(finalDateTime);
        String backendDateTime = DateFormat('d MMM. yyyy, hh:mm a').format(finalDateTime);

        // Update the state only if the widget is still mounted
        if (mounted) {
          setState(() {
            _selectedDate = backendDateTime; // This will hold the formatted date for backend use
          });
        }
      }
    }
  }

  // Method to show the confirmation dialog
  Future<void> _showConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Submission'),
          content: const Text('Are you sure you want to submit your information?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // If user presses "No", close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // If user presses "Yes", submit the form
                _showConfirmationDialog();
                Navigator.of(context).pop(); // Close the dialog
                navigatorKey.currentState?.popAndPushNamed('/u/home');
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() {
    // Validate image, location, date & time, and additional information
    if (_selectedImage == null) {
      _showErrorDialog('Please select an image.');
      return;
    }
    if (_locationController.text.isEmpty) {
      _showErrorDialog('Please provide the location.');
      return;
    }
    if (_rawSelectedDate.isEmpty) {
      _showErrorDialog('Please select a date and time.');
      return;
    }
    if (_infoController.text.isEmpty || _infoController.text.length < 20) {
      _showErrorDialog('Information should be at least 20 characters long.');
      return;
    }

    // If everything is valid, proceed with submission
    _showConfirmationDialog();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
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
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Missing Person:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),  // Round the corners of the box
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Add padding around the text
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white), // Add a white border around the container
                        borderRadius: BorderRadius.circular(20), // Round the corners of the container
                        color: Colors.black.withAlpha(100), // Add a semi-transparent background color
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _missingPersonName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Image:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  _selectedImage != null
                    ? Container(
                        padding: const EdgeInsets.all(16.0),  // Add padding around the image
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white), // Add a white border around the container
                          borderRadius: BorderRadius.circular(20), // Round the corners of the container
                          color: Colors.black.withAlpha(100), // Add a semi-transparent background color
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),  // Make the image rounded (you can adjust the value)
                              child: Image.file(
                                File(_selectedImage!.path),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(16.0), // Padding around the message
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white), // Border around the container
                          borderRadius: BorderRadius.circular(20), // Round the corners
                          color: Colors.black.withAlpha(100), // Semi-transparent background
                        ),
                        child: Center(
                          child: Text(
                            'No image selected.',  // Text message when image is not selected
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),


                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Location:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  TextField(
                    controller: _locationController,
                    maxLines: 1,  // Set the maximum number of lines the text field can expand to
                    minLines: 1,  // Set the minimum height (height will increase with content)
                    cursorColor: Colors.white,
                    maxLength: 16,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      fillColor: Colors.black.withAlpha(100),
                      filled: true,
                      labelStyle: TextStyle(
                        color: Colors.grey.shade300, // Label text color
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                      hintText: 'Moose Jaw, SK',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set border color to white
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set focused border color to white
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set error border color to white
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set error focused border color to white
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding for height
                      counterText: '',
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date & time:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),  // Round the corners of the box
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Add padding around the text
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white), // Add a white border around the container
                        borderRadius: BorderRadius.circular(20), // Round the corners of the container
                        color: Colors.black.withAlpha(100), // Add a semi-transparent background color
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _selectedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Provide information:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  TextField(
                    controller: _infoController,
                    maxLines: 4,  // Set the maximum number of lines the text field can expand to
                    minLines: 4,  // Set the minimum height (height will increase with content)
                    cursorColor: Colors.white,
                    maxLength: 125,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      fillColor: Colors.black.withAlpha(100),
                      filled: true,
                      labelStyle: TextStyle(
                        color: Colors.grey.shade300, // Label text color
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                      hintText: 'Maximum 125 characters and minimum 20 characters allowed.',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set border color to white
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set focused border color to white
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set error border color to white
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white), // Set error focused border color to white
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding for height
                      counterText: '',
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  
                  const SizedBox(height: 16),

                  // Full-width buttons container (with buttons side by side)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _pickImage,
                          style: Styles.button,
                          child: const Text(
                            'Pick Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // Add some space between buttons
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _selectDateTime,
                          style: Styles.button,
                          child: Text(
                            'Select Date & Time',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16), // Add some space before the submit button

                  // Full-width submit button
                  SizedBox(
                    width: double.infinity, // Make submit button take full width
                    child: OutlinedButton(
                      onPressed: _submitForm, // Show confirmation dialog
                      style: Styles.button,
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
