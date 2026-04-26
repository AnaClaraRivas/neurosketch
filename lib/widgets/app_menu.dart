import 'package:flutter/material.dart';
import '../modules/telaenviar.dart';
import '../modules/sobre.dart';


class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Início"),
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),

          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Enviar Desenho"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadPage()),
              );
            },
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SobrePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}