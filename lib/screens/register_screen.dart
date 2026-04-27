import 'package:flutter/material.dart';
import 'package:threads_app/colors.dart';
import 'package:threads_app/services/auth_service.dart';
import 'package:threads_app/widgets/snackbar_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in [_nameController, _userController, _emailController, _passwordController]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if ([_emailController, _passwordController, _userController, _nameController]
        .any((c) => c.text.trim().isEmpty)) {
      SnackbarUtils.showWarning(context, "Please fill in all fields");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _userController.text.trim(),
        _nameController.text.trim(),
      );

      if (mounted) {
        if (user != null) {
          SnackbarUtils.showSuccess(context, "Account created successfully!");
          Navigator.pop(context);
        } else {
          SnackbarUtils.showError(context, "Registration failed. Check your data.");
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.alternate_email, size: 80, color: Colors.white),
              const Text(
                "Create your account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 32),

              _CustomInput(controller: _nameController, hint: "Full Name"),
              const SizedBox(height: 12),
              _CustomInput(controller: _userController, hint: "Username"),
              const SizedBox(height: 12),
              _CustomInput(controller: _emailController, hint: "Email", type: TextInputType.emailAddress),
              const SizedBox(height: 12),
              _CustomInput(controller: _passwordController, hint: "Password", isObscure: true, action: TextInputAction.done),

              const SizedBox(height: 24),

              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          disabledBackgroundColor: Colors.white.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20, width: 20,
                child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
              )
            : const Text("Sign up", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final TextInputType type;
  final TextInputAction action;

  const _CustomInput({
    required this.controller,
    required this.hint,
    this.isObscure = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: type,
      textInputAction: action,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF666666)),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
      ),
    );
  }
}