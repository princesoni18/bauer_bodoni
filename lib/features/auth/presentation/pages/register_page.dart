import 'package:bodoni/features/auth/presentation/pages/login_page.dart';
import 'package:bodoni/features/auth/presentation/pages/widgets/auth_form.dart';
import 'package:bodoni/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/auth_bloc.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthLoading) {
          // Show loading indicator
       
        }

        if (state is AuthAuthenticated) {
          // Navigate to home page or show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );
          Navigator.pushReplacement(context, PageTransition(child: const HomePage(), type: PageTransitionType.rightToLeft));
        }

        if (state is AuthError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFFFD700),
                Color(0xFFF8BBD9),
                Color(0xFFE91E63),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pushReplacement(context, PageTransition(child: const LoginPage(), type: PageTransitionType.leftToRight)),
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      ),
                    ),
                    
                    // Title
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
                            Icons.favorite_border,
                            size: 60,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Join Us',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            'Start Planning Your Dream Wedding',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3),
                    
                    const SizedBox(height: 40),
                    
                    // Register Form
                    AuthForm(
                      isLogin: false,
                      onSubmit: (email, password, name) {
                        context.read<AuthBloc>().add(
                          AuthRegisterRequested(
                            email: email,
                            password: password,
                            name: name ?? '',
                          ),
                        );
                      },
                    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}