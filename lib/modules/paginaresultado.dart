import 'package:flutter/material.dart';
import 'telaenviar.dart';
import 'sobre.dart';

// 👉 IMPORTANTE: reutiliza os mesmos componentes da UploadPage
// então NÃO precisa recriar AnimatedBorderBox se estiver no mesmo projeto

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
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
                      // 🔝 TOP BAR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            "Resultado da Análise",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.menu),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // 🖼️ IMAGEM (FAKE POR ENQUANTO)
                      AnimatedBorderBox(
                        controller: _borderController,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/desenho.png",
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                _Legend(
                                  color: Colors.green,
                                  text: "Padrão típico",
                                ),
                                SizedBox(width: 20),
                                _Legend(
                                  color: Colors.red,
                                  text: "Merece atenção",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🔘 TABS
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mostrarResultados = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: mostrarResultados
                                        ? const Color.fromARGB(
                                            255,
                                            255,
                                            120,
                                            149,
                                          )
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Resultados",
                                      style: TextStyle(
                                        color: mostrarResultados
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mostrarResultados = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: !mostrarResultados
                                        ? const Color.fromARGB(
                                            255,
                                            255,
                                            120,
                                            149,
                                          )
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Explicação",
                                      style: TextStyle(
                                        color: !mostrarResultados
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🔥 CONTEÚDO DINÂMICO
                      mostrarResultados
                          ? Column(
                              children: [
                                AnimatedBorderBox(
                                  controller: _borderController,
                                  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Padrões Típicos Identificados",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "• Uso consistente do espaço do papel\n"
                                        "• Presença de padrões repetitivos naturais\n"
                                        "• Coordenação motora adequada para a idade",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AnimatedBorderBox(
                                  controller: _borderController,
                                  color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Pontos de Atenção",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "• Concentração excessiva em uma área\n"
                                        "• Sobreposição intensa de traços\n"
                                        "• Possível dificuldade de organização visual",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                AnimatedBorderBox(
                                  controller: _borderController,
                                  color: Colors.amber,
                                  child: const Text(
                                    "A análise avalia como a criança utiliza o espaço, "
                                    "repete padrões e aplica força no traço. "
                                    "Esses elementos ajudam a compreender aspectos "
                                    "do desenvolvimento cognitivo e motor.",
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AnimatedBorderBox(
                                  controller: _borderController,
                                  color: Colors.green,
                                  child: const Text(
                                    "Aspectos analisados:\n\n"
                                    "• Organização espacial\n"
                                    "• Padrões repetitivos\n"
                                    "• Pressão do traço\n"
                                    "• Controle motor",
                                  ),
                                ),
                              ],
                            ),

                      const SizedBox(height: 30),

                      // 🔵 BOTÃO
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            80,
                            180,
                            210,
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
                              builder: (_) => const SobrePage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Aprender mais sobre",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ⚪ VOLTAR
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(child: Text("Voltar ao Início")),
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
}

// 🔹 LEGEND
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
