import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  final String _channelName;
  final String _token;
  final String _authEndpoint;

  PusherService({
    required int userId,
    required String token,
  })  : _token = token,
        _channelName = 'private-chat.$userId',
        _authEndpoint = 'http://kadarrentcar.test/broadcasting/auth' {
    // ✅ Inisialisasi Pusher
    PusherChannelsFlutter.getInstance().init(
      apiKey: '1b140c5650d3f2b81ab1',
      cluster: 'ap1',
      onAuthorizer: _onAuthorizer,
      onEvent: _onEvent,
      onError: (message, code, error) {
        print('Pusher error: $message');
      },
      onConnectionStateChange: (currentState, previousState) {
        print('Pusher state: $currentState');
      },
    );
  }

  // 🔥 FUNGSI AUTH MANUAL (wajib untuk private channel)
  Future<Map<String, dynamic>> _onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    final response = await http.post(
      Uri.parse(_authEndpoint),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'socket_id=$socketId&channel_name=$channelName',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Auth failed: ${response.statusCode}');
    }
  }

  // 🔥 FUNGSI CALLBACK UNTUK PESAN
  Function(Map<String, dynamic>)? _messageCallback;

  void bindMessage(Function(Map<String, dynamic>) callback) {
    _messageCallback = callback;
  }

  // 🔥 TANGKAP SEMUA EVENT
  void _onEvent(PusherEvent event) {
    if (event.channelName == _channelName &&
        event.eventName == 'App\\Events\\MessageSent') {
      // event.data itu String JSON
      final data = jsonDecode(event.data as String);
      _messageCallback?.call(data);
    }
  }

  Future<void> connect() async {
    await PusherChannelsFlutter.getInstance().subscribe(
      channelName: _channelName,
    );
    // connect() otomatis jalan
  }

  void disconnect() {
    PusherChannelsFlutter.getInstance().unsubscribe(
      channelName: _channelName,
    );
  }
}