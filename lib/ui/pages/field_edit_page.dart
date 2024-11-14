import 'package:flutter/material.dart';

class EditFieldPage extends StatefulWidget {
  final String label;
  final String initialValue;
  final bool isPassword;

  const EditFieldPage({
    super.key,
    required this.label,
    required this.initialValue,
    this.isPassword = false, // Nilai default false jika bukan password
  });

  @override
  _EditFieldPageState createState() => _EditFieldPageState();
}

class _EditFieldPageState extends State<EditFieldPage> {
  late TextEditingController _controller;
  bool _obscureText = true; // Untuk mengontrol visibilitas teks jika isPassword = true

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveField() {
    // Tambahkan logika penyimpanan di sini, misalnya ke backend atau local storage
    Navigator.pop(context, _controller.text); // Kembali dengan nilai yang diubah
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.label}'),
        backgroundColor: const Color(0xFF00BF63),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit ${widget.label}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              obscureText: widget.isPassword ? _obscureText : false,
              decoration: InputDecoration(
                labelText: widget.label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveField,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BF63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
