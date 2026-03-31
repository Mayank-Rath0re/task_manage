import 'package:flutter/material.dart';
import 'package:task_manage/components/abs_gradient_button.dart';
import 'package:task_manage/components/abs_textfield.dart';
import 'package:task_manage/pages/navigation_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7), // Neutral off-white background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2D2D2D), // Dark charcoal
                    height: 1.05,
                    letterSpacing: -1.5,
                  ),
                  children: [
                    TextSpan(text: "Let's build your\n"),
                    TextSpan(
                      text: 'workspace.',
                      style: TextStyle(
                        color: Color(0xFFB33609), // Dark burnt orange
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // --- FORM CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- AVATAR UPLOAD ---
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 48,
                                backgroundColor: Colors.grey.shade100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey.shade400,
                                  size: 32,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF9E2A0E), // Deep red/brown
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Add your photo',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- FULL NAME FIELD ---
                    const Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AbsTextfield(
                      controller: nameController,
                      hintText: 'e.g. Alexander Pierce',
                      onChanged: () {},
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AbsTextfield(
                      controller: usernameController,
                      hintText: 'e.g. pro_gamer123',
                      onChanged: () {},
                    ),

                    const SizedBox(height: 32),

                    // --- CONTINUE BUTTON ---
                    AbsGradientButton(
                      text: "Continue",
                      suffixIcon: Icon(Icons.arrow_forward, size: 25),
                      alignCenter: true,
                      onPressed: () {
                        // To be replaced with proper signup functionality
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainNavigationScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // --- TERMS TEXT ---
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                              text: "By continuing, you agree to TaskFlow's ",
                            ),
                            TextSpan(
                              text: 'Terms of\nService',
                              style: TextStyle(
                                color: colorScheme.secondary, // Theme Blue
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
