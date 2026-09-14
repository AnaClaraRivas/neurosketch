
import 'package:flutter/material.dart';
import 'telaenviar.dart';
import 'sobre.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _borderController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    // animação do ícone principal
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _iconAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: Curves.easeInOut,
      ),
    );

    // animação das bordas dos cards
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

    return AppScaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: IconBackground(),
          ),

          Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    const SizedBox(height: 20),

                    // ícone principal
                    AnimatedBuilder(
                      animation: _iconAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _iconAnimation.value,
                          child: const Icon(
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

                    const SizedBox(height: 15),

                    const Text(
                      "Análise de desenhos infantis com inteligência artificial",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // botão para enviar um desenho
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 120, 149),
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
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Enviar Desenho",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // card que leva para a página sobre
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SobrePage(),
                          ),
                        );
                      },
                      child: infoCard(
                        icon: Icons.info_outline,
                        color: const Color.fromARGB(255, 148, 238, 125),
                        title: "Sobre o projeto",
                        subtitle:
                            "Entenda a proposta, a análise e como a tecnologia é utilizada.",
                      ),
                    ),

                    const SizedBox(height: 20),

                    // card com uma mensagem sobre o uso dos resultados
                    AnimatedBorderBox(
                      controller: _borderController,
                      color: const Color.fromARGB(255, 255, 188, 212),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.lightbulb_outline,
                              color: Color.fromARGB(255, 255, 120, 149),
                            ),
                          ),

                          SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Uma ferramenta de apoio",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "Os resultados ajudam na observação "
                                  "das produções infantis, mas não "
                                  "substituem a análise e o olhar de "
                                  "profissionais.",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  // card usado nas informações da página inicial
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
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(subtitle),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
        ],
      ),
    );
  }
}

