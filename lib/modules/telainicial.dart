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

      // 🔥 MENU AQUI
      drawer: const AppMenu(),

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
                    const SizedBox(height: 40),

                    // 🔥 BOTÃO MENU
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ícone animado
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
                      "NeuroSketchh",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 120, 149),
                      ),
                    ),

                    const SizedBox(height: 50),

                    AnimatedBorderBox(
                      controller: _borderController,
                      child: const Text(
                        "Análise de desenhos infantis com foco em padrões de desenvolvimento",
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 30),

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
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text(
                        "Enviar Desenho",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 40),

                    infoCard(
                      icon: Icons.info,
                      color: const Color.fromARGB(255, 148, 238, 125),
                      title: "Sobre Neurodivergência",
                      subtitle: "Aprenda sobre Autismo, TDAH e dislexia",
                    ),

                    const SizedBox(height: 20),

                    infoCard(
                      icon: Icons.access_time,
                      color: const Color.fromARGB(255, 87, 204, 239),
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

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // HEADER BONITO
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 120, 149),
            ),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.psychology,
                    color: Color.fromARGB(255, 255, 120, 149),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  "NeuroSketchh",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // INÍCIO
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Início"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),

          // ENVIAR DESENHO
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Enviar Desenho"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onTap: () {
              Navigator.pop(context); // fecha o menu primeiro
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadPage()),
              );
            },
          ),

          // DIVISOR BONITO
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),

          // SOBRE
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
