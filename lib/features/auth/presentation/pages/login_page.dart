import 'package:bodoni/features/auth/presentation/pages/register_page.dart';
import 'package:bodoni/features/auth/presentation/pages/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/auth_bloc.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE91E63),
              Color(0xFFF8BBD9),
              Color(0xFFFFD700),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Logo/Title
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 60,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Wedding Planner',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          'Plan Your Perfect Day',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3),
                  
                  const SizedBox(height: 40),
                  
                  // Login Form
                  AuthForm(
                    isLogin: true,
                    onSubmit: (email, password, name) {
                      context.read<AuthBloc>().add(
                        AuthLoginRequested(email: email, password: password),
                      );
                    },
                  ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),
                  
                  const SizedBox(height: 20),
                  
                  // Register Link
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}