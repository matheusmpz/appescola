import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bem vindo,",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Archivo',
                  color: Color(0xFF061F3E)),
            ),
            Text(
              "Samuel Kanudo!",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Archivo',
                  color: Color(0xFF061F3E)),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Ação do botão
            },
            icon: const Icon(
              Icons.notifications,
              color: Color(0xFF061F3E),
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Container com a imagem de fundo
            Container(
              width: double.infinity, // Ocupa toda a largura
              height: 350, // Altura ajustável
              padding: const EdgeInsets.all(16), // Espaço interno
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/bg-home.png'), // Caminho da imagem
                  fit: BoxFit.cover, // Ajusta a imagem no container
                ),
                borderRadius: BorderRadius.circular(16), // Borda arredondada
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Acesse sua",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF061F3E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Agenda Virtual",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF061F3E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Ação do botão
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF061F3E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      "Ver mais",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
