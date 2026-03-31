import 'package:flutter/material.dart';

class AbsGradientButton extends StatefulWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onPressed;
  final double fontSize;
  final bool alignCenter;
  const AbsGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.fontSize = 17,
    this.alignCenter = false,
  });

  @override
  State<AbsGradientButton> createState() => _AbsGradientButtonState();
}

class _AbsGradientButtonState extends State<AbsGradientButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 64, // Tall, prominent button
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFB33609), // Dark burnt orange
            colorScheme.primary, // Vibrant Theme Orange
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed!();
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Row(
          mainAxisAlignment: widget.alignCenter
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            if (widget.prefixIcon != null) ...[widget.prefixIcon!],
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            if (widget.suffixIcon != null) ...[widget.suffixIcon!],
          ],
        ),
      ),
    );
  }
}
