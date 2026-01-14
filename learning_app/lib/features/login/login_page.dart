import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildWelcome(),
              _buildHeroImage(),
              _buildAuthToggle(),
              _buildForm(),
              _buildPrimaryButton(),
              _buildDivider(),
              _buildSocialButtons(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
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
            child: const Icon(Icons.school, color: Color(0xFF2B8CEE)),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'EduPortal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ---------------- WELCOME ----------------
  Widget _buildWelcome() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Access your courses and learning path anywhere.',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  // ---------------- HERO IMAGE ----------------
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
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TOGGLE ----------------
  Widget _buildAuthToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _toggleButton('Login', true),
            _toggleButton('Sign Up', false),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String text, bool login) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isLogin = login),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isLogin == login ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isLogin == login
                ? [const BoxShadow(color: Colors.black12, blurRadius: 6)]
                : [],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isLogin == login ? const Color(0xFF2B8CEE) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- FORM ----------------
  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _inputLabel('Email Address'),
          _textField('student@university.edu'),
          const SizedBox(height: 12),
          _inputLabel('Password'),
          _passwordField(),
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: (v) => setState(() => rememberMe = v!),
                activeColor: const Color(0xFF2B8CEE),
              ),
              const Text('Remember me'),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _textField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: obscurePassword,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => obscurePassword = !obscurePassword),
        ),
      ),
    );
  }

  // ---------------- BUTTONS ----------------
  Widget _buildPrimaryButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2B8CEE),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          isLogin ? 'Sign In' : 'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR CONTINUE WITH',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.g_mobiledata, color: Colors.green,size: 30),
                SizedBox(width: 5,),
                Text( 'Google',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, color: Colors.black54,size: 30),
                SizedBox(width: 5,),
                Text( 'Continue as Guest',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text(
        'By continuing, you agree to EduPortal’s Terms of Service and Privacy Policy.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, color: Colors.blueGrey),
      ),
    );
  }
}
