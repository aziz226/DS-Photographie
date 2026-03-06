import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GoldButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;

  const GoldButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.filled = false,
  });

  @override
  State<GoldButton> createState() => _GoldButtonState();
}

class _GoldButtonState extends State<GoldButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: (widget.filled || _hovered) ? AppColors.gold : Colors.transparent,
            border: Border.all(color: AppColors.gold, width: 1),
          ),
          child: Text(
            widget.text.toUpperCase(),
            style: AppTheme.cinzel(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: (widget.filled || _hovered) ? AppColors.bg : AppColors.gold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
