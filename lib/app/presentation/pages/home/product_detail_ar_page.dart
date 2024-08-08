import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:go_router/go_router.dart';

class ProductDetailArPage extends StatefulWidget {
  const ProductDetailArPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ProductDetailArPage> createState() => _ProductDetailArPageState();
}

class _ProductDetailArPageState extends State<ProductDetailArPage> {
  UnityWidgetController? _unityWidgetController;

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: UnityWidget(
          fullscreen: true,
          onUnityCreated: onUnityCreated,
          onUnityMessage: _onUnityMessage,
          onUnitySceneLoaded: onUnitySceneLoaded,
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
    setProductId(widget.id);
  }

  // Communcation from Flutter to Unity
  void setProductId(String productId) {
    _unityWidgetController?.postMessage(
      'ID',
      'SetProductId',
      productId,
    );
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    if (sceneInfo != null) {
      setProductId(widget.id);
      // print('Received scene loaded from unity: ${sceneInfo.name}');
      // print(
      //     'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
    }
  }

  void _onUnityMessage(message) {
    // print('Received message from unity: $message');
    context.push('/home/detail/$message');
  }
}
