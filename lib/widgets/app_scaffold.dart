import 'package:flutter/material.dart';
import 'app_menu.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 800;
    double maxWidth = isDesktop ? 500 : double.infinity;

    double sideMargin = isDesktop ? (width - maxWidth) / 2 : 0;

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const AppMenu(),

      body: Stack(
        children: [
          body,

          Positioned(
            top: 40,
            right: isDesktop ? sideMargin + 20 : 20,
            child: Builder(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}