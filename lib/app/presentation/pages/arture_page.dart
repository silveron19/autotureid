import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:go_router/go_router.dart';

class ArturePage extends StatefulWidget {
  const ArturePage({super.key});

  @override
  State<ArturePage> createState() => _ArturePageState();
}

class _ArturePageState extends State<ArturePage> {
  UnityWidgetController? _unityWidgetController;

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UnityWidget(
          fullscreen: true,
          onUnityCreated: onUnityCreated,
          onUnityMessage: _onUnityMessage,
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void _onUnityMessage(message) async {
    context.push('/home/detail/$message');
  }
}
