import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'telaenviar.dart';
import 'telainicial.dart';
import 'sobre.dart';

import '../widgets/app_scaffold.dart';
import '../services/api_service.dart';

class ResultPage extends StatefulWidget {
  final XFile image;

  const ResultPage({super.key, required this.image});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  late AnimationController _borderController;

  // controla qual aba está aparecendo
  bool mostrarResultados = true;

  Map<String, dynamic>? resultado;
  bool carregando = true;

  @override
  void initState() {
    super.initState();

    // animação da borda da imagem
    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // chama a api quando a página abre
    _carregarResultado();
  }

  // pega o resultado da api
  Future<void> _carregarResultado() async {
    try {
      final res = await ApiService.analisarImagem(widget.image);

      // se a pessoa saiu da página enquanto carregava, para aqui
      if (!mounted) return;

      setState(() {
        resultado = res;
        carregando = false;
      });
    } catch (e) {
      // evita erro se a página não estiver mais aberta
      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      print("erro na api: $e");
    }
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  // nomes que podem ser traduzidos para aparecer na tela
  final Map<String, String> traducoes = {
    "cat": "Gato",
    "dog": "Cachorro",
    "person": "Pessoa",
    "figura_humana": "Figura humana",
    "bird": "Pássaro",
    "car": "Carro",
  };

  // explicações para outras classes, caso existam
  final Map<String, String> explicacoes = {
    "cat":
        "Os gatos são mamíferos domésticos conhecidos por sua independência, agilidade e comportamento curioso.",

    "dog":
        "Os cães são animais domesticados há milhares de anos e conhecidos pela lealdade aos seres humanos.",

    "person":
        "Uma pessoa foi identificada na imagem. O modelo reconheceu características corporais humanas.",

    "bird":
        "As aves são animais vertebrados com penas e bico, adaptados para voo ou locomoção terrestre.",

    "car":
        "Um carro é um veículo terrestre utilizado para transporte de pessoas e cargas.",
  };

  // mostra os resultados encontrados pelo modelo
  Widget _buildResultados() {
    if (resultado == null) {
      return const Text("Nenhum resultado encontrado.");
    }

    final List deteccoes = resultado!["deteccoes"] ?? [];
    final int quantidade = resultado!["quantidade_deteccoes"] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // mostra a quantidade de elementos encontrados
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15),
            ],
          ),
          child: Column(
            children: [
              const Icon(
                Icons.psychology,
                size: 50,
                color: Color.fromARGB(255, 80, 180, 210),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  "$quantidade elementos detectados",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // mostra cada detecção encontrada
        ...deteccoes.map<Widget>((d) {
          final classeOriginal = d["nome"] ?? "desconhecido";

          final nome = traducoes[classeOriginal] ?? classeOriginal;

          final confianca = (d["confianca"] ?? 0) * 100;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 22,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$nome identificada",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                const Text("O modelo encontrou este elemento na imagem."),

                const SizedBox(height: 10),

                Text("Precisão: ${confianca.toStringAsFixed(1)}%"),

                const SizedBox(height: 10),

                LinearProgressIndicator(value: confianca / 100, minHeight: 8),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  // mostra a explicação dependendo do resultado do modelo
  Widget _buildExplicacoes() {
    if (resultado == null) {
      return const Text("Nenhuma explicação disponível.");
    }

    final List deteccoes = resultado!["deteccoes"] ?? [];

    // verifica se o modelo encontrou alguma figura humana
    if (deteccoes.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Presença de figura humana",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "O modelo identificou a presença de uma figura humana na imagem.",
            ),

            const SizedBox(height: 15),

            const Text(
              "A representação da figura humana foi definida como "
              "um primeiro elemento de análise por sua relevância "
              "nos estudos sobre desenhos infantis. Esse elemento "
              "pode estar relacionado à forma como a criança "
              "representa a si mesma e envolve dimensões cognitivas, "
              "emocionais e socioculturais presentes em seu processo "
              "de desenvolvimento.",
            ),

            const SizedBox(height: 12),

            const Text(
              "Neste projeto, a identificação da figura humana é "
              "utilizada como um critério de análise da imagem e "
              "não como uma avaliação ou diagnóstico sobre a criança.",
            ),

            const SizedBox(height: 15),

            const Text(
              "Fonte: Nunes, Ferreira e Wiggers (2026). “Colorindo” a imagem corporal: vivências e significados em desenhos infantis de figura humana. Revista Pesquisa Qualitativa.",
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // se não encontrou nenhuma figura humana
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ausência de figura humana",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text("O modelo não identificou uma figura humana na imagem."),

          const SizedBox(height: 15),

          const Text(
            "Esse resultado representa apenas uma característica visual "
            "observada nesta produção. A ausência da figura humana, "
            "por si só, não permite concluir nada sobre o desenvolvimento, "
            "comportamento ou características da criança. Por isso, o "
            "resultado deve ser considerado dentro do contexto da produção "
            "e como um recurso de apoio à observação.",
          ),
          const SizedBox(height: 15),

          const Text(
            "Fonte: Nunes, Ferreira e Wiggers (2026). “Colorindo” a imagem corporal: vivências e significados em desenhos infantis de figura humana. Revista Pesquisa Qualitativa.",
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
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

                      const Text(
                        "Análise do Desenho",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // mostra a imagem que foi enviada
                      AnimatedBorderBox(
                        controller: _borderController,
                        child: ClipRRect(
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
                      ),

                      const SizedBox(height: 25),

                      // botão para trocar entre resultados e explicação
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

                      // mostra a aba escolhida
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: carregando
                            ? const Center(
                                key: ValueKey("loading"),
                                child: CircularProgressIndicator(),
                              )
                            : mostrarResultados
                            ? _buildResultados()
                            : _buildExplicacoes(),
                      ),

                      const SizedBox(height: 30),

                      // botão para abrir a página com mais informações
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
                          "Aprender mais",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // volta para a tela inicial
                      GestureDetector(
                        onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: const Center(child: Text("Voltar ao início")),
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

  // cria os botões das abas
  Widget _toggleButton(String text, bool isLeft) {
    bool ativo = isLeft ? mostrarResultados : !mostrarResultados;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            mostrarResultados = isLeft;
          });
        },
        child: Container(
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
              style: TextStyle(color: ativo ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
