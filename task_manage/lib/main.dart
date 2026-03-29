import 'package:flutter/material.dart';
import 'package:task_manage/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // 1. Defining the Custom Color Scheme from your image
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFFF5F1F), // Vivid Orange
          onPrimary: Colors.white,
          secondary: Color(0xFF007AFF), // Bright Blue
          onSecondary: Colors.white,
          tertiary: Color(0xFF32CD32), // Lime Green
          onTertiary: Colors.white,
          surface: Color(0xFFF8F9FA), // Neutral off-white
          onSurface: Colors.black87,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(
          0xFFE5E5EA,
        ), // A slightly darker background to let neutral cards pop
        // 2. Theming the App Bar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FA),
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),

        // 3. Theming the standard Elevated Button (Primary)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5F1F),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),

        // 4. Theming the Outlined Button
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black87,
            side: const BorderSide(color: Colors.black26),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),

        // 5. Theming the Search Input Field
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIconColor: Colors.grey.shade600,
          hintStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
      //home: const MyHomePage(title: 'Theme Component Showcase'),
      //home: MainNavigationScreen(),
      home: LandingPage(),
    );
  }
}
