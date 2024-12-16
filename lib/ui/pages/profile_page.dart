import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/auth/auth_bloc.dart';
import 'package:toma_scan/ui/pages/help_center_page.dart';
import 'package:toma_scan/ui/pages/privacy_policy_page.dart';
import 'package:toma_scan/ui/pages/terms_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditingUsername = false;
  bool isEditingPassword = false;
  bool _isPasswordVisible = false;
  String? profileImagePath;
  final storage = const FlutterSecureStorage();

  final ImagePicker _picker = ImagePicker();

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _initUsername();
    _initPassword();
  }

  Future<void> _initUsername() async {
    String? username = await storage.read(key: 'username');
    if (username != null) {
      setState(() {
        _usernameController.text =
            username; // Set nilai controller dengan username
      });
    }
  }

  Future<void> _initPassword() async {
    String? password = await storage.read(key: 'password');
    if (password != null) {
      setState(() {
        _passwordController.text =
            password; // Set nilai controller dengan password
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
  void showLogoutDialog(BuildContext context) {
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
                context.read<AuthBloc>().add(AuthLogout());
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
                        obscureText: isPassword &&
                            !_isPasswordVisible, // If password, use _isPasswordVisible
                        decoration: InputDecoration(
                          hintText: isPassword ? "Enter new password" : null,
                          border: const OutlineInputBorder(),
                        ),
                      )
                    : Text(
                        isPassword
                            ? '•' * controller.text.length
                            : controller.text,
                        style: const TextStyle(color: Colors.black54),
                      ),
              ],
            ),
          ),
          IconButton(
            onPressed: isEditing
                ? () {
                    if (isPassword) {
                      // Toggle visibility
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    } else {
                      onSave(); // Save when clicking the pencil icon
                    }
                  }
                : onEditToggle, // Start editing when clicking the pencil icon
            icon: Icon(
              isEditing
                  ? (isPassword && _isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility)
                  : Icons.edit, // Pencil icon when not editing
              color: const Color(0xFF00BF63),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.e)),
            );
          }

          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
          }

          if (state is AuthEditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is AuthEditProfileFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }
          if (state is AuthSuccess || state is AuthEditProfileSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Account',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // Center(
                    //   child: Stack(
                    //     children: [
                    //       Container(
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           border: Border.all(
                    //             color: const Color(0xFF00BF63),
                    //             width: 2,
                    //           ),
                    //           image: profileImagePath != null
                    //               ? DecorationImage(
                    //                   image: FileImage(File(profileImagePath!)),
                    //                   fit: BoxFit.cover,
                    //                 )
                    //               : null,
                    //         ),
                    //         child: profileImagePath == null
                    //             ? const CircleAvatar(
                    //                 backgroundColor: Color(0xFF00BF63),
                    //                 child: Icon(
                    //                   Icons.person,
                    //                   size: 50,
                    //                   color: Colors.white,
                    //                 ),
                    //               )
                    //             : null,
                    //       ),
                    //       Positioned(
                    //         right: 0,
                    //         bottom: 0,
                    //         child: InkWell(
                    //           onTap: _pickImage,
                    //           child: Container(
                    //             padding: const EdgeInsets.all(4),
                    //             decoration: const BoxDecoration(
                    //               color: Color(0xFF00BF63),
                    //               shape: BoxShape.circle,
                    //             ),
                    //             child: const Icon(
                    //               Icons.edit,
                    //               size: 20,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 30),
                    _buildEditableItem(
                      icon: Icons.person_outline,
                      label: "Username",
                      controller: _usernameController,
                      isPassword: false,
                      isEditing: isEditingUsername,
                      onEditToggle: () {
                        setState(() {
                          isEditingUsername = !isEditingUsername;
                        });
                      },
                      onSave: () {
                        setState(() {
                          isEditingUsername = false;
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
                      onSave: () async {
                        setState(() {
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
                            // Validasi apakah username atau password telah diubah
                            if (_usernameController.text.isNotEmpty ||
                                _passwordController.text.isNotEmpty) {
                              // Trigger event AuthUpdateProfile dengan data yang valid
                              context.read<AuthBloc>().add(
                                    AuthUpdateProfile(
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                    ),
                                  );

                              // Reset state editing
                              setState(() {
                                isEditingUsername = false;
                                isEditingPassword = false;
                              });
                            } else {
                              // Tampilkan pesan error jika tidak ada perubahan
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No changes were made.'),
                                ),
                              );
                            }
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                                  builder: (context) =>
                                      const PrivacyPolicyPage(),
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
                                context.read<AuthBloc>().add(AuthLogout());
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
                          // Center(
                          //   child: TextButton(
                          //     onPressed: () {
                          //       _showDeleteDialog(context);
                          //     },
                          //     child: const Text(
                          //       'Delete Account',
                          //       style: TextStyle(
                          //         color: Colors.red,
                          //         fontSize: 16,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('Unknown state. Please try again.'),
          );
        },
      ),
    );
  }
}
