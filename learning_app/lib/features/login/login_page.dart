import 'package:flutter/material.dart';

import '../dashboard/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class MockUser {
  final String name;
  final String email;
  final String password;

  MockUser({
    required this.name,
    required this.email,
    required this.password,
  });
}

class MockAuthStore {
  static final List<MockUser> users = [
    MockUser(
      name: 'Demo Student',
      email: 'student@eduportal.com',
      password: 'password123',
    ),
  ];
}


class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool rememberMe = false;
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _registerMockUser() {
    final email = _emailController.text.trim();

    final alreadyExists = MockAuthStore.users.any(
          (u) => u.email == email,
    );

    if (alreadyExists) {
      _showErrorSnackBar('Email already registered');
      return;
    }

    MockAuthStore.users.add(
      MockUser(
        name: _nameController.text.trim(),
        email: email,
        password: _passwordController.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully 🎉'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear fields
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();

    // Navigate back to login
    setState(() => isLogin = true);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _loginMockUser() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final user = MockAuthStore.users.firstWhere(
          (u) => u.email == email && u.password == password,
      orElse: () => MockUser(name: '', email: '', password: ''),
    );

    if (user.email.isEmpty) {
      _showErrorSnackBar('Invalid email or password');
      return;
    }

    _navigateToDashboard();
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }

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
              Form(
                key: _formKey,
                child: isLogin ? _buildForm() : _buildSignupForm(),
              ),
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
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF2B8CEE).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.school, color: Color(0xFF2B8CEE) ,size: 30,),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'EduPortal',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: AlignmentGeometry.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLogin
                ? Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                : Text(
                    'Create Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
            SizedBox(height: 4),
            isLogin
                ? Text(
                    'Access your courses and learning path anywhere.',
                    style: TextStyle(color: Colors.blueGrey),
                  )
                : Text(
                    'Join our community of learners today.',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
          ],
        ),
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
            isLogin
                ? Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCvKA_KUbGUrFZM6V0DFsjOrrv1hhPZGOKO02VT7siAsP9tL63EunJiN0qYISwRzZUf4atOByEmXSV-mGtcpR2a0KtFDOY6cP1Qb240JRHFwGvU3vKO-Poo1eSqEnNTcsBY8HvOqIO1NEfOUs13Muyo_eXDT3euMgkWPQ9xAH1DWB84jMpBC3zhecjhNF0g39169R82tYELG-qRq36iiUDZ1zEKlVGVWfQ4KeL6uCA81zOES7KEyKFw9974KM5bO72M3yCw3AdIcBk',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.network(
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
                child: isLogin
                    ? const Text(
                        'Empowering your future through knowledge.',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Your Journey',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Unlock premium courses and track your progress.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
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

  // ---------------- LOGIN FORM ----------------
  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _inputLabel('Email Address'),
          _emailField(),
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
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- SIGNUP FORM ----------------
  Widget _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _inputLabel('Full Name'),
          _nameField(),
          const SizedBox(height: 12),
          _inputLabel('Email Address'),
          _emailField(),
          const SizedBox(height: 12),
          _inputLabel('Password'),
          _passwordField(),
          const SizedBox(height: 12),
          _inputLabel('Confirm Password'),
          _passwordField(isConfirm: true),
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

  Widget _nameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        hintText: 'John Doe',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'student@eduportal.com',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _passwordField({bool isConfirm = false}) {
    return TextFormField(
      controller: isConfirm ? _confirmPasswordController : _passwordController,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        hintText: isConfirm ? 'Confirm password' : 'Enter your password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () => setState(() {
            obscurePassword = !obscurePassword;
          }),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (isConfirm && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  // ---------------- BUTTONS ----------------
  Widget _buildPrimaryButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          final isValid = _formKey.currentState!.validate();

          if (!isValid) {
            if (_emailController.text.isEmpty) {
              _showErrorSnackBar('Email is required');
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                .hasMatch(_emailController.text)) {
              _showErrorSnackBar('Enter a valid email address');
            } else if (_passwordController.text.isEmpty) {
              _showErrorSnackBar('Password is required');
            } else if (_passwordController.text.length < 6) {
              _showErrorSnackBar('Password must be at least 6 characters');
            } else if (!isLogin &&
                _confirmPasswordController.text !=
                    _passwordController.text) {
              _showErrorSnackBar('Passwords do not match');
            }
            return;
          }
          if (isLogin) {
            _loginMockUser();
          } else {
            _registerMockUser();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2B8CEE),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          isLogin ? 'Sign In' : 'Sign Up',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
                const Icon(Icons.g_mobiledata, color: Colors.green, size: 30),
                SizedBox(width: 5),
                Text(
                  'Google',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
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
                const Icon(Icons.person, color: Colors.black54, size: 30),
                SizedBox(width: 5),
                Text(
                  'Continue as Guest',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
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
