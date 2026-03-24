import 'package:flutter/material.dart';
import 'telaenviar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _borderController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _iconAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );

    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _iconController.dispose();
    _borderController.dispose();
    super.dispose();
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

          Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    // icone animado
                    AnimatedBuilder(
                      animation: _iconAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _iconAnimation.value,
                          child: Icon(
                            Icons.psychology,
                            size: 140,
                            color: Color.fromARGB(255, 255, 120, 149),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "NeuroSketch",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 120, 149),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // borda animada
                    AnimatedBorderBox(
                      controller: _borderController,
                      child: const Text(
                        "Análise de desenhos infantis com foco em padrões de desenvolvimento",
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // botão
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UploadPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text(
                        "Enviar Desenho",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 40),

                    infoCard(
                      icon: Icons.info,
                      color: Color.fromARGB(255, 148, 238, 125),
                      title: "Sobre Neurodivergência",
                      subtitle: "Aprenda sobre Autismo, TDAH e dislexia",
                    ),

                    const SizedBox(height: 20),

                    infoCard(
                      icon: Icons.access_time,
                      color: Color.fromARGB(255, 87, 204, 239),
                      title: "Desenhos Anteriores",
                      subtitle: "Veja análises já realizadas!",
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return AnimatedBorderBox(
      controller: _borderController,
      color: color,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// borda animada
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

// painter
class AnimatedBorderPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  AnimatedBorderPainter(this.color, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 20.0;
    const dashWidth = 10.0;
    const dashSpace = 6.0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
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

// fundo com icons
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
    return Icon(icon, size: 60, color: Color.fromARGB(10, 0, 0, 0));
  }
}
