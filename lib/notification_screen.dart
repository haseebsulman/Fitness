import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to notification settings
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          NotificationTile(
            icon: Icons.fitness_center,
            title: 'Workout Reminder',
            subtitle: 'Time for your afternoon workout session',
            time: '2 hours ago',
            isRead: false,
          ),
          NotificationTile(
            icon: Icons.water_drop,
            title: 'Hydration Alert',
            subtitle: 'Remember to drink water',
            time: '4 hours ago',
            isRead: true,
          ),
          NotificationTile(
            icon: Icons.local_fire_department,
            title: 'Goal Achievement',
            subtitle: 'You burned 2000 calories today!',
            time: '1 day ago',
            isRead: true,
          ),
          NotificationTile(
            icon: Icons.people,
            title: 'New Follower',
            subtitle: 'John started following you',
            time: '2 days ago',
            isRead: true,
          ),
          NotificationTile(
            icon: Icons.bedtime,
            title: 'Sleep Tracker',
            subtitle: 'You slept for 7 hours last night',
            time: '2 days ago',
            isRead: true,
          ),
          NotificationTile(
            icon: Icons.fastfood,
            title: 'Diet Log Reminder',
            subtitle: 'Don’t forget to log your lunch!',
            time: '3 days ago',
            isRead: false,
          ),
          NotificationTile(
            icon: Icons.check_circle_outline,
            title: 'Milestone Unlocked',
            subtitle: 'You’ve completed 10 workouts this week!',
            time: '3 days ago',
            isRead: true,
          ),
          NotificationTile(
            icon: Icons.calendar_today,
            title: 'Upcoming Challenge',
            subtitle: 'Join the 7-day fitness challenge!',
            time: '4 days ago',
            isRead: true,
          ),
          NotificationTile(
            icon: Icons.update,
            title: 'App Update',
            subtitle: 'New features have been added!',
            time: '5 days ago',
            isRead: true,
          ),
          NotificationTile(
            icon: Icons.security,
            title: 'Privacy Notice',
            subtitle: 'Review the updated privacy policy.',
            time: '6 days ago',
            isRead: true,
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isRead ? Colors.grey[200] : Colors.blue[50],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isRead ? Colors.grey : Colors.blue),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      trailing: !isRead
          ? Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      )
          : null,
      onTap: () {
        // Handle notification tap
      },
    );
  }
}
