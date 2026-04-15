import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'paginaresultado.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with TickerProviderStateMixin {
  late AnimationController _borderController;

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  Future<void> _tirarFoto() async {
    final XFile? foto = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (foto != null) {
      setState(() {
        _image = foto;
      });
    }
  }

  Future<void> _escolherGaleria() async {
    final XFile? imagem = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (imagem != null) {
      setState(() {
        _image = imagem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 800;
    double maxWidth = isDesktop ? 500 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned.fill(child: IconBackground()),

          SafeArea(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TOP BAR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            "Enviar Desenho",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.menu),
                        ],
                      ),

                      const SizedBox(height: 30),

                      AnimatedBorderBox(
                        controller: _borderController,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color.fromARGB(
                                255,
                                255,
                                120,
                                149,
                              ).withOpacity(0.2),
                              backgroundImage: _image != null
                                  ? NetworkImage(_image!.path)
                                  : null,
                              child: _image == null
                                  ? const Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Color.fromARGB(255, 255, 120, 149),
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Adicione o desenho",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Tire uma foto ou escolha da galeria",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // BOTÃO FOTO
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            120,
                            149,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _tirarFoto,
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        label: const Text(
                          "Tirar Foto do Desenho",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // GALERIA
                      GestureDetector(
                        onTap: _escolherGaleria,
                        child: AnimatedBorderBox(
                          controller: _borderController,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.image),
                              SizedBox(width: 10),
                              Text("Escolher da Galeria"),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      AnimatedBorderBox(
                        controller: _borderController,
                        color: Colors.amber,
                        child: Row(
                          children: const [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(60, 255, 193, 7),
                              child: Icon(Icons.lightbulb, color: Colors.amber),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                "Fotografe com boa iluminação e mantenha a câmera paralela ao papel",
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      AnimatedBorderBox(
                        controller: _borderController,
                        color: Colors.blue,
                        child: Row(
                          children: const [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(60, 33, 150, 243),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                "Desenhos serão salvos automaticamente",
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 120, 149),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _image == null
                            ? null // desativa se não tiver imagem
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResultPage(),
                                  ),
                                );
                              },
                        child: const Text(
                          "Próximo",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProximaPage extends StatelessWidget {
  const ProximaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Próxima Página")),
      body: const Center(child: Text("Aqui vai a análise do desenho")),
    );
  }
}

// componentes
class IconBackground extends StatelessWidget {
  const IconBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned(top: 100, left: 30, child: BgIcon(Icons.psychology)),
        Positioned(top: 200, right: 40, child: BgIcon(Icons.favorite)),
        Positioned(top: 350, left: 60, child: BgIcon(Icons.psychology)),
        Positioned(top: 500, right: 50, child: BgIcon(Icons.favorite)),
        Positioned(top: 650, left: 80, child: BgIcon(Icons.psychology)),
      ],
    );
  }
}

class BgIcon extends StatelessWidget {
  final IconData icon;

  const BgIcon(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 60, color: const Color.fromARGB(30, 0, 0, 0));
  }
}

class AnimatedBorderBox extends StatelessWidget {
  final Widget child;
  final AnimationController controller;
  final Color color;

  const AnimatedBorderBox({
    super.key,
    required this.child,
    required this.controller,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, childWidget) {
        return CustomPaint(
          painter: AnimatedBorderPainter(color, controller.value),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}

class AnimatedBorderPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AnimatedBorderPainter(this.color, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 10.0;
    const dashSpace = 6.0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final rect = Offset.zero & size;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(20)));

    final metrics = path.computeMetrics();

    for (var metric in metrics) {
      double distance = animationValue * (dashWidth + dashSpace);

      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant AnimatedBorderPainter oldDelegate) => true;
}
