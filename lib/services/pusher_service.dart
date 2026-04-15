import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:car_rent_mobile_app/config/api_config.dart';

class PusherService {
  final String _channelName;
  final String _token;
  final String _authEndpoint;
  bool _isConnected = false;

  PusherService({
    required int userId,
    required String token,
  })  : _token = token,
        _channelName = 'private-chat.$userId',
        _authEndpoint = AppConfig.broadcastingAuthUrl {
    PusherChannelsFlutter.getInstance().init(
      apiKey: '1b140c5650d3f2b81ab1',
      cluster: 'ap1',
      onAuthorizer: _onAuthorizer,
      onEvent: _onEvent,
      onError: (String message, int? code, dynamic error) {
      },
      onConnectionStateChange: (dynamic currentState, dynamic previousState) {
      },
      onSubscriptionSucceeded: (String channelName, dynamic data) {
      },
      onSubscriptionError: (String message, dynamic error) {
      },
    );
  }

  // 🔥 FUNGSI AUTH MANUAL
  Future<Map<String, dynamic>> _onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(_authEndpoint),
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'socket_id': socketId,
          'channel_name': channelName,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Authorization failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stack) {
      print(stack);
      rethrow;
    }
  }

  // 🔥 FUNGSI CALLBACK
  Function(Map<String, dynamic>)? _messageCallback;

  void bindMessage(Function(Map<String, dynamic>) callback) {
    _messageCallback = callback;
  }

  // 🔥 TANGKAP EVENT
  void _onEvent(PusherEvent event) {
    final expected = [
      'App\\Events\\MessageSent',
      'App\\\\Events\\\\MessageSent',
      '.MessageSent',
      'MessageSent',
      'message.sent',
      '.message.sent',
    ];

    if (event.channelName == _channelName && expected.contains(event.eventName)) {

      try {
        Map<String, dynamic> data = {};
        if (event.data is String) {
          data = jsonDecode(event.data as String);
        } else if (event.data is Map) {
          data = Map<String, dynamic>.from(event.data as Map);
        }

        _messageCallback?.call(data);
      } catch (e, stack) {
        print(stack);
      }
    } else {
    }
  }

  // 🔥 CONNECT & SUBSCRIBE
  Future<void> connect() async {
    try {
      // Subscribe ke channel
      await PusherChannelsFlutter.getInstance().subscribe(
        channelName: _channelName,
      );
      
      _isConnected = true;
    } catch (e) {
      print('❌ [CONNECT] Failed: $e');
      rethrow;
    }
  }

  void disconnect() {
    PusherChannelsFlutter.getInstance().unsubscribe(
      channelName: _channelName,
    );
  }
  
  bool get isConnected => _isConnected;
}