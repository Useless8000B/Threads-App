import 'package:flutter/material.dart';
import 'package:threads_app/screens/register_screen.dart';
import 'package:threads_app/services/auth_service.dart';
import 'package:threads_app/widgets/snackbar_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      SnackbarUtils.showWarning(context, "Please enter email and password");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await _authService.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user == null) {
        if (mounted) {
          setState(() => _isLoading = false);
          SnackbarUtils.showError(context, "Login failed. Check your credentials.");
        }
      } else {
        if (mounted) {
          SnackbarUtils.showSuccess(context, "Welcome back!");
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackbarUtils.showError(context, "An error occurred: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons.alternate_email, size: 80, color: Colors.white),
            const SizedBox(height: 40),

            _buildTextField(_emailController, "Email"),
            const SizedBox(height: 12),
            _buildTextField(_passwordController, "Password", isObscure: true),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                      )
                    : const Text(
                        "Log in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ),

            const SizedBox(height: 15),
            const Text(
              "Forgot password?",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),

            const Spacer(),

            const Divider(color: Color(0xFF1F1F1F)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildTextField(TextEditingController controller, String hint, {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF666666)),
        filled: true,
        fillColor: const Color(0xFF121212),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1F1F1F)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1F1F1F)),
        ),
      ),
    );
  }
}