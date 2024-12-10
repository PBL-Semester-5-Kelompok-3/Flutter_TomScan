import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/auth/auth_bloc.dart';
import 'package:toma_scan/ui/pages/help_center_page.dart';
import 'package:toma_scan/ui/pages/privacy_policy_page.dart';
import 'package:toma_scan/ui/pages/terms_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "Astrid Risa";
  String email = "astridrisa@gmail.com";
  String phone = "089529167474";
  String password = "************";
  bool isEditingUsername = false;
  bool isEditingEmail = false;
  bool isEditingPhone = false;
  bool isEditingPassword = false;
  String? profileImagePath;

  final ImagePicker _picker = ImagePicker();

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: username);
    _emailController = TextEditingController(text: email);
    _phoneController = TextEditingController(text: phone);
    _passwordController = TextEditingController(text: password);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImagePath = pickedFile.path;
      });
    }
  }

  // Fungsi untuk konfirmasi logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog

                // Trigger logout event
                context.read<AuthBloc>().add(const AuthLogout());
              },
              child: const Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk konfirmasi delete account
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
              'This cannot be undone. All your plants and care reminders will be lost.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logika delete account di sini
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan alert sukses setelah tombol Save ditekan
  void _showSaveSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your changes have been saved successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableItem({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditToggle,
    required VoidCallback onSave,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                isEditing
                    ? TextField(
                        controller: controller,
                        obscureText: isPassword,
                        decoration: InputDecoration(
                          hintText: isPassword ? "Enter new password" : null,
                          border: const OutlineInputBorder(),
                        ),
                      )
                    : Text(
                        isPassword ? '************' : controller.text,
                        style: const TextStyle(color: Colors.black54),
                      ),
              ],
            ),
          ),
          IconButton(
            onPressed: isEditing ? onSave : onEditToggle,
            icon: Icon(isEditing ? Icons.check : Icons.edit,
                color: const Color(0xFF00BF63)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              barrierDismissible: false,
            );
          } else {
            // Tutup dialog loading
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (state is AuthLogoutSuccess) {
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is AuthLogoutFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF00BF63),
                            width: 2,
                          ),
                          image: profileImagePath != null
                              ? DecorationImage(
                                  image: FileImage(File(profileImagePath!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: profileImagePath == null
                            ? const CircleAvatar(
                                backgroundColor: Color(0xFF00BF63),
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF00BF63),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildEditableItem(
                  icon: Icons.person_outline,
                  label: "Username",
                  controller: _usernameController,
                  isEditing: isEditingUsername,
                  onEditToggle: () {
                    setState(() {
                      isEditingUsername = !isEditingUsername;
                    });
                  },
                  onSave: () {
                    setState(() {
                      username = _usernameController.text;
                      isEditingUsername = false;
                    });
                  },
                ),
                _buildEditableItem(
                  icon: Icons.email_outlined,
                  label: "E-mail",
                  controller: _emailController,
                  isEditing: isEditingEmail,
                  onEditToggle: () {
                    setState(() {
                      isEditingEmail = !isEditingEmail;
                    });
                  },
                  onSave: () {
                    setState(() {
                      email = _emailController.text;
                      isEditingEmail = false;
                    });
                  },
                ),
                _buildEditableItem(
                  icon: Icons.phone_outlined,
                  label: "Phone",
                  controller: _phoneController,
                  isEditing: isEditingPhone,
                  onEditToggle: () {
                    setState(() {
                      isEditingPhone = !isEditingPhone;
                    });
                  },
                  onSave: () {
                    setState(() {
                      phone = _phoneController.text;
                      isEditingPhone = false;
                    });
                  },
                ),
                _buildEditableItem(
                  icon: Icons.lock_outline,
                  label: "Password",
                  controller: _passwordController,
                  isEditing: isEditingPassword,
                  isPassword: true,
                  onEditToggle: () {
                    setState(() {
                      isEditingPassword = !isEditingPassword;
                    });
                  },
                  onSave: () {
                    setState(() {
                      password = _passwordController.text;
                      isEditingPassword = false;
                    });
                  },
                ),
                Center(
                  child: SizedBox(
                    width: 400,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        _showSaveSuccessDialog(
                            context); // Tampilkan alert sukses
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BF63),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.description_outlined,
                            color: Colors.black54),
                        title: const Text('Terms and Conditions'),
                        trailing: const Icon(Icons.chevron_right,
                            color: Colors.black54),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TermsPage(),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.shield_outlined,
                            color: Colors.black54),
                        title: const Text('Privacy Policy'),
                        trailing: const Icon(Icons.chevron_right,
                            color: Colors.black54),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyPage(),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.help_outline,
                            color: Colors.black54),
                        title: const Text('Help Center'),
                        trailing: const Icon(Icons.chevron_right,
                            color: Colors.black54),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelpCenterPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            _showDeleteDialog(context);
                          },
                          child: const Text(
                            'Delete Account',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
