import 'package:car_rent_mobile_app/services/micro_services/auth_service.dart';
import 'package:car_rent_mobile_app/styles/app_color.dart';
import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../services/models/chat_models.dart';
import '../../services/pusher_service.dart';

class ChatScreen extends StatefulWidget {
  final int adminId;

  const ChatScreen({super.key, this.adminId = 1});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late PusherService _pusher;
  int? _currentUserId;
  String? _token;
  List<ChatMessage> _messages = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    final userId = await AuthService.getUserId();
    final token = await AuthService.getToken();

    if (userId == null || token == null) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }

    setState(() {
      _currentUserId = userId;
      _token = token;
    });

    await _loadMessages();
    _initPusher();
  }

  _loadMessages() async {
    final messages = await ApiService.getMessages(widget.adminId, _token!);
    setState(() {
      _messages = messages;
      _loading = false;
    });
  }

  _initPusher() async {
    _pusher = PusherService(userId: _currentUserId!, token: _token!);
    _pusher.bindMessage((data) {
      final msg = ChatMessage.fromJson(data);
      if (mounted) {
        setState(() {
          _messages.add(msg);
          _loading = false;
        });
      }
    });
    _pusher.connect();
  }

  _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final msg = await ApiService.sendMessage(widget.adminId, _controller.text, _token!);
    setState(() {
      _messages.add(msg);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(child: CircularProgressIndicator(color: AppColors.blue)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Kadar Rent Car Admin Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg.senderId == _currentUserId;
                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.message),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pusher.disconnect();
    _controller.dispose();
    super.dispose();
  }
}
