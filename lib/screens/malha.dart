import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class FaceCoordinatesScreen extends StatefulWidget {
  @override
  _FaceCoordinatesScreenState createState() => _FaceCoordinatesScreenState();
}

class _FaceCoordinatesScreenState extends State<FaceCoordinatesScreen> {
  ArCoreFaceController? arCoreFaceController;
  String faceCoordinates = "Nenhum rosto detectado";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('malha Faces'),
      ),
      body: ArCoreFaceView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableAugmentedFaces: true,
        debug: false //true para aparecer malha, porem algum bug do plugin não libera,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreFaceController controller) {
    arCoreFaceController = controller;
  }

  @override
  void dispose() {
    arCoreFaceController?.dispose();
    super.dispose();
  }
}
