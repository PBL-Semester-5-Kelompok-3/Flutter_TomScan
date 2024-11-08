import 'package:flutter/material.dart';
import 'package:toma_scan/ui/widgets/profile_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFF00BF63),
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
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
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ProfileItem(
                icon: Icons.person_outline,
                label: 'Username',
                value: 'Astrid Risa',
                onEdit: () {},
              ),
              ProfileItem(
                icon: Icons.email_outlined,
                label: 'E-mail',
                value: 'astridrisa@gmail.com',
                onEdit: () {},
              ),
              ProfileItem(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: '089529167474',
                onEdit: () {},
              ),
              ProfileItem(
                icon: Icons.lock_outline,
                label: 'Password',
                value: '************',
                onEdit: () {},
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BF63),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tentang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProfileItem(
                      icon: Icons.description_outlined,
                      label: 'Syarat dan Ketentuan',
                      value: '',
                      onEdit: () {},
                    ),
                    const Divider(),
                    ProfileItem(
                      icon: Icons.shield_outlined,
                      label: 'Kebijakan Privasi',
                      value: '',
                      onEdit: () {},
                    ),
                    const Divider(),
                    ProfileItem(
                      icon: Icons.help_outline,
                      label: 'Pusat Bantuan',
                      value: '',
                      onEdit: () {},
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {},
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
                        onPressed: () {},
                        child: const Text(
                          'Delete',
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
      // bottomNavigationBar: BottomNavBarWidget(
      //   currentIndex: 4,
      //   onTap: (index) {
      //     // Handle navigation
      //   },
      // ),
    );
  }
}
