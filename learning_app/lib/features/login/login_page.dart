import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              _buildHeader(),
              _buildWelcome(),
              _buildHeroImage(),
            ],
          ),
          ),
      ),
    );
  }
}

Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF2B8CEE).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.school, color: Color(0xFF2B8CEE), size: 28),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'EduPortal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    ),
  );
}

Widget _buildWelcome() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text(
          'Access your courses and learning path anywhere.',
          style: TextStyle(fontSize: 16,color: Colors.blueGrey),
        ),
      ],
    ),
  );
}

Widget _buildHeroImage() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCvKA_KUbGUrFZM6V0DFsjOrrv1hhPZGOKO02VT7siAsP9tL63EunJiN0qYISwRzZUf4atOByEmXSV-mGtcpR2a0KtFDOY6cP1Qb240JRHFwGvU3vKO-Poo1eSqEnNTcsBY8HvOqIO1NEfOUs13Muyo_eXDT3euMgkWPQ9xAH1DWB84jMpBC3zhecjhNF0g39169R82tYELG-qRq36iiUDZ1zEKlVGVWfQ4KeL6uCA81zOES7KEyKFw9974KM5bO72M3yCw3AdIcBk',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: const Text(
                'Empowering your future through knowledge.',
                style: TextStyle(fontSize:18,color: Colors.white, fontWeight: FontWeight.bold,),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
