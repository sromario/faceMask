import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';

class AugmentedFacesScreen extends StatefulWidget {
  @override
  AugmentedFacesScreenState createState() => AugmentedFacesScreenState();
}

class AugmentedFacesScreenState extends State<AugmentedFacesScreen> {
  ArCoreFaceController? arCoreFaceController;

  // Lista de máscaras disponíveis
  final List<Map<String, String>> masks = [
    {'texture': 'assets/venom.jpg', 'model': 'venom.sfb'},
    {'texture': 'assets/venom_with_eyes.jpg', 'model': 'venom_with_eyes.sfb'},
    {'texture': 'assets/fox_face_mesh_texture.png', 'model': 'fox_face.sfb'},
  ];

  int selectedMaskIndex = 0; // Índice da máscara selecionada

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rolagem de Máscaras 3D'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ArCoreFaceView(
                onArCoreViewCreated: _onArCoreViewCreated,
                enableAugmentedFaces: true,
        
              ),
            ),
            Container(
              height: 100,
              child: PageView.builder(
                itemCount: masks.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedMaskIndex = index;
                    _changeMask();
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      'Máscara ${index + 1}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreFaceController controller) {
    arCoreFaceController = controller;
    _changeMask(); // Carrega a primeira máscara por padrão
  }

  Future<void> _changeMask() async {
    final selectedMask = masks[selectedMaskIndex];

    final ByteData textureBytes = await rootBundle.load(selectedMask['texture']!);
    arCoreFaceController?.loadMesh(
      textureBytes: textureBytes.buffer.asUint8List(),
      skin3DModelFilename: selectedMask['model']!,
    );

    print("Máscara ${selectedMaskIndex + 1} carregada!");
  }

  @override
  void dispose() {
    arCoreFaceController?.dispose();
    super.dispose();
  }
}
