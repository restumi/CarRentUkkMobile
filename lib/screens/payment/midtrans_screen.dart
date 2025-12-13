import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../styles/app_color.dart';

class MidtransScreen extends StatefulWidget {
  final String snapToken;

  const MidtransScreen({super.key, required this.snapToken});

  @override
  State<MidtransScreen> createState() => _MidtransScreenState();
}

class _MidtransScreenState extends State<MidtransScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final url = 'https://app.sandbox.midtrans.com/snap/v3/redirection/${widget.snapToken}';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text('Payment'),
        centerTitle: true,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}