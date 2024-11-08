import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4; // Sesuaikan dengan tab profil

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Implement navigasi ke halaman lain sesuai dengan index
    if (index == 0) {
      // Navigasi ke halaman Home
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Navigasi ke halaman Informatif
      Navigator.pushReplacementNamed(context, '/informatif');
    } else if (index == 2) {
      // Navigasi ke halaman Identify Leaf
      Navigator.pushReplacementNamed(context, '/identify_leaf');
    } else if (index == 3) {
      // Navigasi ke halaman History
      Navigator.pushReplacementNamed(context, '/history');
    } else if (index == 4) {
      // Tetap di halaman Profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Row(
          children: [
            Icon(Icons.eco, color: Colors.green),
            SizedBox(width: 8),
            Text(
              'TomaScan',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          Icon(Icons.notifications, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.delete, color: Colors.red),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'My Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage('https://placehold.co/100x100'),
                ),
              ),
              SizedBox(height: 16),
              ProfileItem(
                icon: Icons.person,
                label: 'Username',
                value: 'Astrid Risa',
              ),
              ProfileItem(
                icon: Icons.email,
                label: 'E-mail',
                value: 'astridrisa@gmail.com',
              ),
              ProfileItem(
                icon: Icons.phone,
                label: 'Phone',
                value: '089529167474',
              ),
              ProfileItem(
                icon: Icons.lock,
                label: 'Password',
                value: '**********',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Save'),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tentang',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    AboutItem(
                      icon: Icons.description,
                      label: 'Syarat dan Ketentuan',
                    ),
                    AboutItem(
                      icon: Icons.privacy_tip,
                      label: 'Kebijakan Privasi',
                    ),
                    AboutItem(
                      icon: Icons.help,
                      label: 'Pusat Bantuan',
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
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
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                  Text(
                    value,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.edit, color: Colors.black),
        ],
      ),
    );
  }
}

class AboutItem extends StatelessWidget {
  final IconData icon;
  final String label;

  AboutItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Icon(Icons.chevron_right, color: Colors.black),
        ],
      ),
    );
  }
}
