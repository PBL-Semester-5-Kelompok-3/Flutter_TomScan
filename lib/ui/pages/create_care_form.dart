import 'package:flutter/material.dart';

class CreateEducationForm extends StatefulWidget {
  const CreateEducationForm({Key? key}) : super(key: key);

  @override
  State<CreateEducationForm> createState() => _CreateEducationFormState();
}

class _CreateEducationFormState extends State<CreateEducationForm> {
  final _titleController = TextEditingController();
  final _steps1Controller = TextEditingController();
  final _steps2Controller = TextEditingController();
  final _steps3Controller = TextEditingController();
  final Map<int, String> _selectedImages = {};

  void _showSuccessNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('New Education has been created'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _handleSubmit() {
    // Validate form
    if (_titleController.text.isEmpty ||
        _steps1Controller.text.isEmpty ||
        _steps2Controller.text.isEmpty ||
        _steps3Controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Show success notification and pop
    _showSuccessNotification();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _steps1Controller.dispose();
    _steps2Controller.dispose();
    _steps3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section with green background and worker image
              Stack(
                children: [
                  // Green background
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: const Color(0xFF4CAF50),
                  ),
                  // Back button
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // Worker image
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/worker.png',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              // Form section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EDUCATION FORM',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Title field
                    _buildFormField(
                      'Title',
                      Icons.eco,
                      'Write what you want ...',
                      controller: _titleController,
                    ),
                    const SizedBox(height: 20),
                    // Steps fields with images
                    _buildStepField(
                      'Steps 1',
                      1,
                      _steps1Controller,
                    ),
                    const SizedBox(height: 20),
                    _buildStepField(
                      'Steps 2',
                      2,
                      _steps2Controller,
                    ),
                    const SizedBox(height: 20),
                    _buildStepField(
                      'Steps 3',
                      3,
                      _steps3Controller,
                    ),
                    const SizedBox(height: 30),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.red[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextButton(
                            onPressed: _handleSubmit,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Accept',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    IconData icon,
    String hint, {
    TextEditingController? controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.green[300],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildStepField(
    String label,
    int stepNumber,
    TextEditingController controller,
  ) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.eco,
                color: Colors.green[300],
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '$stepNumber',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Write what you want ...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedImages[stepNumber] = 'Dummy image path';
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: _selectedImages[stepNumber] != null
                  ? Center(
                      child: Text(
                        'Image selected',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.grey[600]),
                        SizedBox(height: 4),
                        Text(
                          'Input your image',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Write what you want ...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
