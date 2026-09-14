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

    // animação da borda dos cards
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
          const Positioned.fill(
            child: IconBackground(),
          ),

          SafeArea(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // botão para voltar
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // título da página
                      const Text(
                        "Sobre o projeto",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // explicação geral sobre o projeto
                      AnimatedBorderBox(
                        controller: _borderController,
                        child: _CardInfo(
                          color: const Color.fromARGB(
                            226,
                            255,
                            188,
                            212,
                          ),
                          icon: Icons.child_care,
                          title: "Por que analisar desenhos?",
                          text:
                              "Os desenhos infantis são uma forma de expressão "
                              "e fazem parte do desenvolvimento da criança. "
                              "Por meio das produções gráficas, é possível "
                              "observar diferentes aspectos visuais, como "
                              "traços, formas, organização e elementos "
                              "representados.\n\n"
                              "Por isso, o projeto busca utilizar a tecnologia "
                              "como uma forma de auxiliar a observação dessas "
                              "produções de maneira mais organizada e "
                              "contextualizada.",
                        ),
                      ),

                      const SizedBox(height: 25),

                      // explica o objetivo do aplicativo
                      _buildSection(
                        "O que o projeto faz?",
                        const Color.fromARGB(255, 255, 120, 149),
                        [
                          "analisa imagens de desenhos infantis",
                          "utiliza inteligência artificial para encontrar padrões visuais",
                          "começa pela identificação de figuras humanas",
                          "organiza os resultados para facilitar a observação",
                        ],
                      ),

                      // explica o primeiro critério usado no projeto
                      _buildSection(
                        "Por que a figura humana?",
                        const Color.fromARGB(255, 244, 170, 80),
                        [
                          "a figura humana é um elemento importante nos estudos sobre desenhos infantis",
                          "ela pode aparecer de diferentes formas nas produções das crianças",
                          "o projeto utiliza sua presença ou ausência como primeiro critério de análise",
                          "esse critério permite testar a capacidade da inteligência artificial de reconhecer elementos gráficos",
                        ],
                      ),

                      // explica como a inteligência artificial participa
                      AnimatedBorderBox(
                        controller: _borderController,
                        color: const Color.fromARGB(255, 112, 180, 220),
                        child: _CardInfo(
                          color: const Color.fromARGB(
                            45,
                            112,
                            180,
                            220,
                          ),
                          icon: Icons.auto_awesome,
                          title: "Como a inteligência artificial funciona?",
                          text:
                              "O aplicativo utiliza um modelo de visão "
                              "computacional baseado na arquitetura YOLO. "
                              "Durante o treinamento, o modelo recebe "
                              "imagens previamente organizadas e marcadas "
                              "para aprender a identificar determinados "
                              "elementos visuais.\n\n"
                              "Neste protótipo, o modelo foi treinado para "
                              "identificar a presença de uma figura humana "
                              "em uma imagem.",
                        ),
                      ),

                      const SizedBox(height: 25),

                      // explica o que significa encontrar uma figura humana
                      _buildSection(
                        "Quando uma figura humana é encontrada",
                        const Color.fromARGB(255, 102, 190, 130),
                        [
                          "o modelo identifica uma possível figura humana na imagem",
                          "o resultado indica apenas o que foi encontrado pelo modelo",
                          "a identificação não representa uma avaliação sobre a criança",
                        ],
                      ),

                      // explica o que significa não encontrar
                      _buildSection(
                        "Quando uma figura humana não é encontrada",
                        const Color.fromARGB(255, 150, 130, 210),
                        [
                          "o modelo não encontrou uma figura humana dentro dos critérios aprendidos",
                          "isso não significa que exista algum problema com o desenho",
                          "a ausência é apenas uma das categorias utilizadas pelo projeto",
                          "o resultado deve ser observado junto com o contexto da produção",
                        ],
                      ),

                      // deixa claro o limite da ferramenta
                      AnimatedBorderBox(
                        controller: _borderController,
                        color: const Color.fromARGB(255, 235, 170, 90),
                        child: _CardInfo(
                          color: const Color.fromARGB(
                            40,
                            235,
                            170,
                            90,
                          ),
                          icon: Icons.info_outline,
                          title: "Importante",
                          text:
                              "O aplicativo não realiza diagnóstico e não "
                              "determina características psicológicas ou "
                              "cognitivas da criança.\n\n"
                              "Os resultados devem ser entendidos como "
                              "informações complementares para a observação "
                              "das produções gráficas. A interpretação "
                              "deve considerar o contexto, as características "
                              "individuais da criança e a avaliação de "
                              "profissionais responsáveis pelo acompanhamento.",
                        ),
                      ),

                      const SizedBox(height: 25),

                      // explica a proposta pedagógica
                      _buildSection(
                        "Para que o projeto foi criado?",
                        const Color.fromARGB(255, 90, 175, 190),
                        [
                          "auxiliar professores e profissionais da educação",
                          "facilitar a organização das informações observadas nos desenhos",
                          "acompanhar produções ao longo do tempo",
                          "contribuir para uma observação mais individualizada",
                          "usar tecnologia como apoio, sem substituir a análise humana",
                        ],
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

  // cria as seções com os pontos principais
  Widget _buildSection(
    String title,
    Color color,
    List<String> items,
  ) {
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
              // título da seção
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.25),
                    child: Icon(
                      Icons.circle,
                      color: color,
                      size: 10,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // mostra os pontos da seção
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    "• $item",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// card usado para textos maiores
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
          // ícone do card
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Colors.pink,
            ),
          ),

          const SizedBox(height: 10),

          // título do card
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // texto principal
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
