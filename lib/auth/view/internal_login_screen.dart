import 'package:eventary_prototype/auth/model/auth_user.dart';
import 'package:eventary_prototype/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class InternalLoginScreen extends StatefulWidget {
  const InternalLoginScreen({
    super.key,
    required this.authViewModel,
  });

  final AuthViewModel authViewModel;

  @override
  State<InternalLoginScreen> createState() =>
      _InternalLoginScreenState();
}

class _InternalLoginScreenState
    extends State<InternalLoginScreen> {
  static const Color navy = Color(0xFF172033);
  static const Color navyLight = Color(0xFF202B42);
  static const Color gold = Color(0xFFC09B60);
  static const Color cream = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);
  static const Color border = Color(0xFFE3E5E8);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage(
        'Email dan password wajib diisi.',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await widget.authViewModel.login(
      email: email,
      password: password,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (!success) {
      _showMessage(
        'Email atau password salah.',
      );
      return;
    }

    final user = widget.authViewModel.currentUser;

    if (user == null) return;

    if (user.role == UserRole.superAdmin) {
      Navigator.pushReplacementNamed(
        context,
        '/super-admin',
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/admin',
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          if (isMobile) {
            return _mobileLayout();
          }

          return _desktopLayout();
        },
      ),
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _desktopLayout() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1100,
            minHeight: 650,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 35,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: _brandingPanel(),
              ),
              Expanded(
                flex: 4,
                child: _loginPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BRANDING PANEL
  // ============================================================

  Widget _brandingPanel() {
    return Container(
      height: 650,
      decoration: const BoxDecoration(
        color: navy,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: gold.withValues(alpha: 0.18),
                  width: 1,
                ),
              ),
            ),
          ),

          Positioned(
            left: -100,
            bottom: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.06),
                  width: 1,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(55),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Spacer(),

                Container(
                  width: 52,
                  height: 4,
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'EVENTARY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 4,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'PROPERTY VISUALIZATION',
                  style: TextStyle(
                    color: gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  'Internal Management\nSystem',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'Kelola properti, penyewaan, maintenance, '
                  'event, dan operasional dalam satu sistem '
                  'terintegrasi.',
                  style: TextStyle(
                    color:
                        Colors.white.withValues(alpha: 0.68),
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),

                const Spacer(),

                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: gold.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.business_outlined,
                        color: gold,
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Authorized Internal Access',
                      style: TextStyle(
                        color: Colors.white
                            .withValues(alpha: 0.65),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOGIN PANEL
  // ============================================================

  Widget _loginPanel() {
    return Container(
      height: 650,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 55,
        vertical: 55,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Spacer(),

          const Text(
            'Welcome Back',
            style: TextStyle(
              color: navy,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 9),

          const Text(
            'Sign in to access the internal system.',
            style: TextStyle(
              color: textGrey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 40),

          const Text(
            'Email',
            style: TextStyle(
              color: navy,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 9),

          _textField(
            controller: emailController,
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType:
                TextInputType.emailAddress,
          ),

          const SizedBox(height: 23),

          const Text(
            'Password',
            style: TextStyle(
              color: navy,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 9),

          _textField(
            controller: passwordController,
            hint: 'Enter your password',
            icon: Icons.lock_outline,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword =
                      !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: textGrey,
                size: 20,
              ),
            ),
            onSubmitted: (_) => login(),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : login,
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(9),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: gold.withValues(
                              alpha: 0.9,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 25),

          Center(
            child: Text(
              'For authorized personnel only',
              style: TextStyle(
                color:
                    textGrey.withValues(alpha: 0.75),
                fontSize: 11,
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSubmitted: onSubmitted,
      style: const TextStyle(
        color: navy,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: textGrey.withValues(alpha: 0.65),
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: textGrey,
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFFAFAF9),
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: navy,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _mobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(35),
            color: navy,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'EVENTARY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'PROPERTY VISUALIZATION',
                  style: TextStyle(
                    color: gold,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(28),
            child: _loginPanel(),
          ),
        ],
      ),
    );
  }
}