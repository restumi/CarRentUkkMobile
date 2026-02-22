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
  final ScrollController _scrollController = ScrollController();

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
      return;
    }

    setState(() {
      _currentUserId = userId;
      _token = token;
    });

    await _loadMessages();
    _initPusher();
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await ApiService.getMessages(widget.adminId, _token!);
      if (mounted) {
        setState(() {
          _messages = messages;
          _loading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal load pesan: $e')));
      }
    }
  }

  void _initPusher() async {
    _pusher = PusherService(userId: _currentUserId!, token: _token!);
    _pusher.bindMessage((data) {
      final msg = ChatMessage.fromJson(data);
      if (mounted) {
        setState(() {
          if (!_messages.any((m) => m.id == msg.id)) {
            _messages.add(msg);
          }
        });
        _scrollToBottom();
      }
    });
    _pusher.connect();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final text = _controller.text;
    _controller.clear();

    try {
      final msg = await ApiService.sendMessage(widget.adminId, text, _token!);
      if (mounted) {
        setState(() {
          _messages.add(msg);
        });
        _scrollToBottom();
      }
    } catch (e) {
      _controller.text = text;
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal kirim: $e')));
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool _isInSameGroup(ChatMessage msg1, ChatMessage msg2) {
    if (msg1.senderId != msg2.senderId) return false;

    final time1 = _parseMessageTime(msg1);
    final time2 = _parseMessageTime(msg2);

    if (time1 == null || time2 == null) return false;

    final diff = time1.difference(time2).inMinutes.abs();
    return diff < 2;
  }

  DateTime? _parseMessageTime(ChatMessage msg) {
    final timeStr = msg.createdAt;
    try {
      return DateTime.parse(timeStr);
    } catch (_) {
      return null;
    }
  }

  String _formatTimeDisplay(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  bool _shouldShowTimestamp(int index) {
    if (index == _messages.length - 1) return true;

    final currentMsg = _messages[index];
    final nextMsg = _messages[index + 1];

    return !_isInSameGroup(currentMsg, nextMsg);
  }

  BorderRadius _getBubbleRadius(int index) {
    final msg = _messages[index];
    final isMe = msg.senderId == _currentUserId;
    final largeRadius = const Radius.circular(16);
    final zeroRadius = Radius.zero;

    final hasPrevInGroup =
        index > 0 && _isInSameGroup(msg, _messages[index - 1]);
    final hasNextInGroup =
        index < _messages.length - 1 &&
        _isInSameGroup(msg, _messages[index + 1]);

    if (!hasPrevInGroup && !hasNextInGroup) {
      return BorderRadius.only(
        topLeft: largeRadius,
        topRight: largeRadius,
        bottomLeft: isMe ? largeRadius : zeroRadius,
        bottomRight: isMe ? zeroRadius : largeRadius,
      );
    }
    if (!hasPrevInGroup && hasNextInGroup) {
      return BorderRadius.only(
        topLeft: largeRadius,
        topRight: largeRadius,
        bottomLeft: isMe ? largeRadius : zeroRadius,
        bottomRight: isMe ? zeroRadius : largeRadius,
      );
    }
    if (hasPrevInGroup && !hasNextInGroup) {
      return BorderRadius.only(
        topLeft: isMe ? largeRadius : zeroRadius,
        topRight: isMe ? zeroRadius : largeRadius,
        bottomLeft: largeRadius,
        bottomRight: largeRadius,
      );
    }
    return BorderRadius.only(
      topLeft: isMe ? largeRadius : zeroRadius,
      topRight: isMe ? zeroRadius : largeRadius,
      bottomLeft: isMe ? largeRadius : zeroRadius,
      bottomRight: isMe ? zeroRadius : largeRadius,
    );
  }

  Widget _buildMessageBubble(ChatMessage msg, bool isMe, BorderRadius radius) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.blue : const Color.fromARGB(255, 97, 97, 97),
          borderRadius: radius,
        ),
        child: Text(
          msg.message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pusher.disconnect();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(child: CircularProgressIndicator(color: AppColors.blue)),
      );
    }

    final bottomPadding = 70.0 + MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // ===== Chat Messages Area =====
          Padding(
            padding: EdgeInsets.only(top: 80, bottom: bottomPadding),
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg.senderId == _currentUserId;
                final showTimestamp = _shouldShowTimestamp(index);
                final bubbleRadius = _getBubbleRadius(index);
                final msgTime = _parseMessageTime(msg);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 2,
                  ),
                  child: Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        _buildMessageBubble(msg, isMe, bubbleRadius),

                        if (showTimestamp && msgTime != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            _formatTimeDisplay(msgTime),
                            style: TextStyle(
                              color: isMe ? Colors.blue[200] : Colors.grey[500],
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ===== Header =====
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/header_chat.png',
              width: MediaQuery.of(context).size.width * 0.48,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.015,
            right: 0,
            child: Image.asset(
              'assets/images/logo_header_chat.png',
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            left: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // ===== Bottom Input Bar =====
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.black,
                border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan...',
                        hintStyle: const TextStyle(color: AppColors.abuGelap),
                        filled: true,
                        fillColor: Colors.grey[900],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      keyboardType: TextInputType.text,
                      maxLines: null,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
