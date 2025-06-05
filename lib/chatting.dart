import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatContact> contacts = [
    ChatContact(
      name: 'Fitness Coach',
      lastMessage: 'How was your workout today?',
      time: '10:30 AM',
      unreadCount: 2,
      isOnline: true,
      avatar: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    ChatContact(
      name: 'Nutritionist',
      lastMessage: 'Here is your meal plan for tomorrow',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
      avatar: 'https://randomuser.me/api/portraits/women/2.jpg',
    ),
    ChatContact(
      name: 'Workout Buddy',
      lastMessage: 'Let\'s train together this weekend!',
      time: '2 days ago',
      unreadCount: 0,
      isOnline: true,
      avatar: 'https://randomuser.me/api/portraits/men/3.jpg',
    ),
    ChatContact(
      name: 'Support Team',
      lastMessage: 'Your issue has been resolved',
      time: '1 week ago',
      unreadCount: 0,
      isOnline: false,
      avatar: 'https://randomuser.me/api/portraits/women/4.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: _searchChats,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: _filterChats,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ChatTile(
                  contact: contact,
                  onTap: () => _openChat(context, contact),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _startNewChat,
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }

  void _searchChats() {
    // Implement search functionality
    showSearch(
      context: context,
      delegate: ChatSearchDelegate(contacts: contacts),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('New group'),
              onTap: () {
                Navigator.pop(context);
                // Create new group
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification settings'),
              onTap: () {
                Navigator.pop(context);
                // Open notification settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Chat settings'),
              onTap: () {
                Navigator.pop(context);
                // Open chat settings
              },
            ),
          ],
        );
      },
    );
  }

  void _filterChats(String query) {
    // Implement filtering logic
    setState(() {
      // Filter contacts based on query
    });
  }

  void _openChat(BuildContext context, ChatContact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(contact: contact),
      ),
    );
  }

  void _startNewChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewChatScreen(),
      ),
    );
  }
}

class ChatContact {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String avatar;

  ChatContact({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.avatar,
  });
}

class ChatTile extends StatelessWidget {
  final ChatContact contact;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildAvatar(),
      title: Text(
        contact.name,
        style: TextStyle(
          fontWeight: contact.unreadCount > 0
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        contact.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: contact.unreadCount > 0
              ? FontWeight.bold
              : FontWeight.normal,
          color: contact.unreadCount > 0
              ? Colors.black
              : Colors.grey,
        ),
      ),
      trailing: _buildTrailing(),
      onTap: onTap,
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(contact.avatar),
        ),
        if (contact.isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTrailing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          contact.time,
          style: TextStyle(
            color: contact.unreadCount > 0
                ? Colors.blue
                : Colors.grey,
            fontSize: 12,
          ),
        ),
        if (contact.unreadCount > 0)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Text(
              contact.unreadCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

class ChatDetailScreen extends StatelessWidget {
  final ChatContact contact;

  const ChatDetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(contact.avatar),
            ),
            const SizedBox(width: 10),
            Text(contact.name),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                // Chat messages would go here
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New chat'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New group'),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Contacts'),
          ),
          // List of contacts would go here
        ],
      ),
    );
  }
}

class ChatSearchDelegate extends SearchDelegate {
  final List<ChatContact> contacts;

  ChatSearchDelegate({required this.contacts});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = contacts.where((contact) =>
        contact.name.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final contact = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(contact.avatar),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.lastMessage),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(contact: contact),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}