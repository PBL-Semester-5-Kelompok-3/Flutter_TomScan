import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "Reminder Schedule",
      message: "Ingat untuk menyiram tanaman tomat pagi ini agar tetap lembap! Pastikan tidak terlalu basah.",
      time: "07:00 AM",
      icon: Icons.calendar_today,
      date: "Today",
    ),
    NotificationItem(
      title: "System Update Available",
      message: "Pembaruan sistem terbaru siap diinstal! Nikmati peningkatan performa dan perbaikan bug untuk pengalaman yang lebih lancar.",
      time: "08:46 AM",
      icon: Icons.system_update,
      date: "Today",
    ),
    NotificationItem(
      title: "Reminder Schedule",
      message: "Periksa daun tomat hari ini untuk mendeteksi tanda-tanda stres atau penyakit sejak dini.",
      time: "10:54 AM",
      icon: Icons.calendar_today,
      date: "Yesterday",
    ),
    NotificationItem(
      title: "Reminder Schedule",
      message: "Periksa daun tomat hari ini untuk mendeteksi tanda-tanda stres atau penyakit sejak dini.",
      time: "10:54 AM",
      icon: Icons.calendar_today,
      date: "1 November 2024",
    ),
  ];

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 || notifications[index - 1].date != notification.date)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    notification.date,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ListTile(
                leading: Icon(notification.icon, color: Colors.grey),
                title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.message),
                    const SizedBox(height: 4),
                    Text(notification.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final String date;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.date,
  });
}
