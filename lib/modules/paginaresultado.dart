import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'telaenviar.dart';
import 'telainicial.dart';
import 'sobre.dart';
import '../widgets/app_scaffold.dart';

class ResultPage extends StatefulWidget {
  final XFile image;

  const ResultPage({super.key, required this.image});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with TickerProviderStateMixin {
  late AnimationController _borderController;

  bool mostrarResultados = true;

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
                        "Análise do Desenho",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🔥 IMAGEM
                      AnimatedBorderBox(
                        controller: _borderController,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: kIsWeb
                                  ? Image.network(
                                      widget.image.path,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(widget.image.path),
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                _Legend(color: Colors.green, text: "Padrão típico"),
                                SizedBox(width: 20),
                                _Legend(color: Colors.red, text: "Atenção"),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🔥 TOGGLE
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            _toggleButton("Resultados", true),
                            _toggleButton("Explicação", false),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🔥 CONTEÚDO BONITO
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: mostrarResultados
                            ? Column(
                                key: const ValueKey(1),
                                children: [
                                  _contentBox(
                                    color: Colors.green,
                                    icon: Icons.check_circle,
                                    title: "Pontos Positivos",
                                    items: [
                                      "Uso equilibrado do espaço",
                                      "Boa repetição de padrões",
                                      "Coordenação motora consistente",
                                      "Distribuição organizada",
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  _contentBox(
                                    color: Colors.red,
                                    icon: Icons.warning,
                                    title: "Pontos de Atenção",
                                    items: [
                                      "Concentração em áreas específicas",
                                      "Sobreposição de traços",
                                      "Possível dificuldade de organização",
                                      "Variação de pressão",
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                key: const ValueKey(2),
                                children: [
                                  _contentBox(
                                    color: Colors.amber,
                                    icon: Icons.psychology,
                                    title: "Como funciona",
                                    description:
                                        "A análise observa padrões no desenho como organização, repetição e controle do traço.\n\nEsses elementos ajudam a entender o desenvolvimento cognitivo.",
                                  ),
                                  const SizedBox(height: 20),
                                  _contentBox(
                                    color: Colors.blue,
                                    icon: Icons.analytics,
                                    title: "O que é analisado",
                                    items: [
                                      "Organização espacial",
                                      "Repetição de padrões",
                                      "Intensidade do traço",
                                      "Controle motor",
                                      "Distribuição visual",
                                    ],
                                  ),
                                ],
                              ),
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 80, 180, 210),
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
                              builder: (_) => const SobrePage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Aprender mais",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // 🔥 VOLTAR PRO INÍCIO DE VERDADE
                      GestureDetector(
                        onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomePage()),
                          (route) => false,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: const Center(
                            child: Text(
                              "Voltar ao início",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
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

  Widget _toggleButton(String text, bool isLeft) {
    bool ativo = isLeft ? mostrarResultados : !mostrarResultados;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            mostrarResultados = isLeft;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: ativo
                ? const Color.fromARGB(255, 255, 120, 149)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: ativo ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 BOX BONITO COM LISTA OU TEXTO
  Widget _contentBox({
    required Color color,
    required IconData icon,
    required String title,
    List<String>? items,
    String? description,
  }) {
    return AnimatedBorderBox(
      controller: _borderController,
      color: color,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(icon, color: color, size: 18),
                ),
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

            if (description != null) Text(description),

            if (items != null)
              ...items.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text("• $e"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// legenda
class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}