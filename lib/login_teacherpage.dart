import 'package:flutter/material.dart';

class LoginPageTeacher extends StatelessWidget {
  const LoginPageTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    const inputTextColor = Color(0xFF061F3E);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login do',
                style: TextStyle(
                  fontSize: 39,
                  fontWeight: FontWeight.w400,
                  color: inputTextColor,
                ),
              ),
              const Text(
                'Professor',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: inputTextColor,
                ),
              ),
              const SizedBox(height: 40),
              const TextField(
                style: TextStyle(color: inputTextColor),
                decoration: InputDecoration(
                  labelText: 'Email:',
                  labelStyle: TextStyle(color: inputTextColor),
                  filled: true,
                  fillColor: Color(0xFFEDEDED),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                style: TextStyle(color: inputTextColor),
                decoration: InputDecoration(
                  labelText: 'Senha:',
                  labelStyle: TextStyle(color: inputTextColor),
                  filled: true,
                  fillColor: Color(0xFFEDEDED),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                style: TextStyle(color: inputTextColor),
                decoration: InputDecoration(
                  labelText: 'Acesso Institucional:',
                  labelStyle: TextStyle(color: inputTextColor),
                  filled: true,
                  fillColor: Color(0xFFEDEDED),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // ação de cancelar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: inputTextColor,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // ação de login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6633),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
