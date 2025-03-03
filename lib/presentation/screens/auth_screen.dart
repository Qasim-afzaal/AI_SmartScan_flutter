import 'package:barcode_scanner/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/view_model/auth_viewmodel.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            if (authViewModel.error?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  authViewModel.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 24),
            _buildAuthButton(authViewModel),
            TextButton(
              onPressed: () => setState(() => _isLogin = !_isLogin),
              child: Text(_isLogin 
                  ? 'Create new account' 
                  : 'I already have an account'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButton(AuthViewModel authViewModel) {
    return authViewModel.isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () => _authenticateUser(authViewModel),
            child: Text(_isLogin ? 'Login' : 'Sign Up'),
          );
  }

  void _authenticateUser(AuthViewModel authViewModel) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    
    if (_isLogin) {
      authViewModel.login(email, password);
    } else {
      authViewModel.signUp(email, password);
    }
  }
}
