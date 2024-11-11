import 'package:flutter/material.dart';
import 'package:toma_scan/ui/widgets/profile_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
             Center(
              child: SizedBox(
                width: 400,
                height: 40, 
                child: ElevatedButton(
                  onPressed: () {},
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
                      'Tentang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Icon(Icons.description_outlined, color: Colors.black54),
                      title: const Text('Syarat dan Ketentuan'),
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(Icons.shield_outlined, color: Colors.black54),
                      title: const Text('Kebijakan Privasi'),
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(Icons.help_outline, color: Colors.black54),
                      title: const Text('Pusat Bantuan'),
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                      onTap: () {},
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
