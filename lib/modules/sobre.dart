import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import 'paginaresultado.dart';
import 'telaenviar.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage>
    with TickerProviderStateMixin {
  late AnimationController _borderController;

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 800;
    double maxWidth = isDesktop ? 500 : double.infinity;

    return AppScaffold(
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
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Sobre Diferenças Cognitivas",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🔥 CARD PRINCIPAL MAIS SUAVE
                      AnimatedBorderBox(
                        controller: _borderController,
                        child: _CardInfo(
                          color: const Color.fromARGB(226, 255, 188, 212),
                          icon: Icons.psychology,
                          title: "Entendendo o tema",
                          text:
                              "Diferenças cognitivas são formas variadas de funcionamento do cérebro. Algumas condições podem trazer dificuldades no aprendizado, memória ou organização, enquanto outras representam apenas maneiras diferentes de pensar.\n\nA neurodivergência inclui condições como TDAH, autismo e dislexia — nem todas são deficiências, mas todas representam diversidade.",
                        ),
                      ),

                      const SizedBox(height: 25),

                      _buildSection("Autismo (TEA)", Colors.pink, [
                        "Padrões repetitivos",
                        "Foco intenso em detalhes",
                        "Preferência por organização",
                      ]),

                      _buildSection("TDAH", Colors.amber, [
                        "Mudança rápida de ideias",
                        "Impulsividade",
                        "Dificuldade de foco",
                      ]),

                      _buildSection("Dislexia", Colors.green, [
                        "Troca ou inversão de letras",
                        "Dificuldade de leitura",
                      ]),

                      _buildSection("Dispraxia", Colors.blue, [
                        "Coordenação motora limitada",
                        "Traços irregulares",
                      ]),

                      const SizedBox(height: 40),
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

  Widget _buildSection(String title, Color color, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: AnimatedBorderBox(
        controller: _borderController,
        color: color,
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.25),
                    child: Icon(Icons.circle, color: color, size: 10),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ...items.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text("• $e"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String text;

  const _CardInfo({
    required this.color,
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.pink),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}