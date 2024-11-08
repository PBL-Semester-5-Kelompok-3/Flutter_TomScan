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
                  backgroundImage: NetworkImage(
                      'data:image/jpeg;base64,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'),
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
