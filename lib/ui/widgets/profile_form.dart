import 'package:flutter/material.dart';
import '../widgets/editable_field.dart';

class ProfileForm extends StatefulWidget {
  final bool isEditing;
  final VoidCallback onSave;

  const ProfileForm({
    super.key,
    required this.isEditing,
    required this.onSave,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _usernameController = TextEditingController(text: 'Astrid Risa');
  final TextEditingController _emailController = TextEditingController(text: 'astridrisa@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '089529167474');
  final TextEditingController _passwordController = TextEditingController(text: '************');

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      widget.onSave();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EditableField(
            label: 'Username',
            icon: Icons.person_outline,
            controller: _usernameController,
            isEditing: widget.isEditing,
          ),
          EditableField(
            label: 'E-mail',
            icon: Icons.email_outlined,
            controller: _emailController,
            isEditing: widget.isEditing,
          ),
          EditableField(
            label: 'Phone',
            icon: Icons.phone_outlined,
            controller: _phoneController,
            isEditing: widget.isEditing,
          ),
          EditableField(
            label: 'Password',
            icon: Icons.lock_outline,
            controller: _passwordController,
            isEditing: widget.isEditing,
            isPassword: true,
          ),
          if (widget.isEditing)
            Center(
              child: SizedBox(
                width: 400,
                height: 40,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BF63),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}