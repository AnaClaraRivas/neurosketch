import 'package:flutter/material.dart';
import 'telaenviar.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

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
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            "Sobre",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.menu),
                        ],
                      ),

                      const SizedBox(height: 30),

                      _CardInfo(
                        color: const Color.fromARGB(255, 255, 229, 238),
                        icon: Icons.psychology,
                        title: "Como Funcionam as Diferenças Cognitivas",
                        text:
                            "Doenças ou deficiências cognitivas são condições que dificultam o aprendizado, o raciocínio, a memória e a compreensão de informações. Elas podem surgir por fatores genéticos, neurológicos ou pelo desenvolvimento atípico. A neurodivergência, por sua vez, é um termo mais amplo que descreve maneiras diferentes de o cérebro funcionar, como no TDAH, autismo e dislexia. Nem toda neurodivergência é uma deficiência cognitiva — algumas pessoas têm apenas um jeito diferente de pensar —, mas certas neurodivergências podem envolver dificuldades cognitivas. Assim, a neurodivergência inclui tanto condições que causam limitações quanto diferenças que não são doenças.",
                      ),

                      const SizedBox(height: 25),

                      _buildSection("Autismo (TEA)", Colors.pink.shade200, [
                        "Padrões comuns no desenho:",
                        "Padrões repetitivos",
                        "Foco em detalhes",
                        "Preferência por simetria",
                      ]),

                      _buildSection("TDAH", Colors.yellow.shade200, [
                        "Mudança de ideias",
                        "Impulsividade",
                        "Desorganização",
                      ]),

                      _buildSection("Dislexia", Colors.green.shade200, [
                        "Inversão de formas",
                        "Dificuldade visual",
                      ]),

                      _buildSection("Dispraxia", Colors.blue.shade200, [
                        "Traços irregulares",
                        "Dificuldade motora",
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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color, radius: 8),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.35),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text("• $e"),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
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
        border: Border.all(color: Colors.pink, width: 1.5),
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
