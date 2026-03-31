import 'package:flutter/material.dart';
import 'package:task_manage/components/abs_gradient_button.dart';
import 'package:task_manage/pages/onboarding_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // Neutral off-white background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pushes the content slightly down from the top
              const Spacer(flex: 1),

              // --- BADGE ---
              RichText(
                text: TextSpan(
                  text: 'TaskFlow',
                  style: TextStyle(
                    color: colorScheme.secondary,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // --- HEADLINE ---
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 64, // Massive font size
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2D2D2D), // Dark charcoal
                    height: 0.95, // Very tight line height for stacked look
                    letterSpacing: -2.5, // Tight tracking
                  ),
                  children: [
                    const TextSpan(text: 'Master Your\nDay with\n'),
                    TextSpan(
                      text: 'Precision\nVitality.',
                      style: TextStyle(
                        color: colorScheme.primary, // Theme Orange
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'A high-end editorial task\nexperience designed for the kinetic\nworkflow. Weightless organization\nfor heavy-hitting goals.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Pushes the button to the bottom
              const Spacer(flex: 2),

              // --- GET STARTED BUTTON ---
              AbsGradientButton(
                text: "GET STARTED",
                suffixIcon: Icon(Icons.arrow_forward, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16), // Bottom breathing room
            ],
          ),
        ),
      ),
    );
  }
}
