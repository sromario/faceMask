import 'package:flutter/services.dart';
import '../arcore_flutter_plugin.dart';

typedef FaceDetectedCallback = void Function(Map<String, dynamic>? faceData); // Definição do tipo de callback

class ArCoreFaceController {
  ArCoreFaceController({
    int? id,
    this.enableAugmentedFaces = true,
    this.debug = false,
  }) {
    _channel = MethodChannel('arcore_flutter_plugin_$id');
    _channel.setMethodCallHandler(_handleMethodCalls);
    init();
  }

  final bool enableAugmentedFaces;
  final bool debug;
  late MethodChannel _channel;
  FaceDetectedCallback? onFaceDetected; // Campo para o callback
  late StringResultHandler onError;

  init() async {
    try {
      await _channel.invokeMethod<void>('init', {
        'enableAugmentedFaces': enableAugmentedFaces,
      });
      if (debug) {
        print("ARCore Face Tracking inicializado com sucesso.");
      }
    } on PlatformException catch (ex) {
      print("Erro ao inicializar ARCore: ${ex.message}");
    }
  }

  Future<dynamic> _handleMethodCalls(MethodCall call) async {
    if (debug) {
      print('_platformCallHandler call ${call.method} ${call.arguments}');
    }
    switch (call.method) {
      case 'onError':
        onError(call.arguments);
        break;
      case 'onFaceDetected': // Adiciona o evento onFaceDetected
        if (onFaceDetected != null) {
          onFaceDetected!(call.arguments);
        }
        break;
      default:
        if (debug) {
          print('Unknown method ${call.method}');
        }
    }
    return Future.value();
  }

  Future<void> loadMesh({
    required Uint8List textureBytes,
    required String skin3DModelFilename,
  }) {
    return _channel.invokeMethod('loadMesh', {
      'textureBytes': textureBytes,
      'skin3DModelFilename': skin3DModelFilename,
    });
  }

  void dispose() {
    _channel.invokeMethod<void>('dispose');
  }
}
