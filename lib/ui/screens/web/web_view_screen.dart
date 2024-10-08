// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static String routeName = "web";
  bool ara = true;

  WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  bool isBuild = false;

  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)?.settings.arguments as String;
    if (!isBuild) {
      isBuild = true;
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.disabled)
        ..loadRequest(Uri.parse(argument))
        ..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) {
          widget.ara = false;
          setState(() {});
        }));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "web site",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: widget.ara
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: controller,
            ),
    );
  }
}
